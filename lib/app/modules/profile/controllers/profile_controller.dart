import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final emailC = TextEditingController();
  final nameC = TextEditingController();
  final phoneC = TextEditingController();

  RxBool isLoading = false.obs;

  XFile? image;

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      if (kDebugMode) print(e);
      Get.snackbar('Error', 'Logout Failed!');
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = _auth.currentUser!.uid;
      final dataUsers = await _firestore.collection('users').doc(uid).get();
      return dataUsers.data();
    } catch (e) {
      if (kDebugMode) print(e);
      Get.snackbar('Error', 'Failed to get data!');
      return null;
    }
  }

  void imagePicker() async {
    final picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) update();
  }

  void updateProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (nameC.text.isNotEmpty && phoneC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final uid = _auth.currentUser!.uid;

        await _firestore.collection('users').doc(uid).update({
          'name': nameC.text.trim(),
          'phone': phoneC.text.trim(),
        });

        if (image != null) {
          final ext = image!.name.split('.').last;
          final storageRef = _storage.ref(uid).child('profile.$ext');
          await storageRef.putFile(File(image!.path));

          final urlImage = await storageRef.getDownloadURL();
          await _firestore.collection('users').doc(uid).update({
            'img_profile': urlImage,
          });
        }

        isLoading.value = false;
        Get.snackbar('Success', 'Profile successfully updated');
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) print(e);
        Get.snackbar('Error', 'Failed to update data!');
      }
    } else {
      Get.snackbar('Warning', 'The input field cannot be empty!');
    }
  }
}
