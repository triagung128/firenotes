import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController emailC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();

  RxBool isLoading = false.obs;

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar('Terjadi Kesalahan', 'Tidak dapat logout');
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = _auth.currentUser!.uid;
      var dataUser = await _firestore.collection('users').doc(uid).get();

      return dataUser.data();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar('Terjadi Kesalahan', 'Gagal get data');
      return null;
    }
  }

  void updateProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (nameC.text.isNotEmpty && phoneC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = _auth.currentUser!.uid;
        await _firestore.collection('users').doc(uid).update({
          'name': nameC.text.trim(),
          'phone': phoneC.text.trim(),
        });
        isLoading.value = false;
        Get.snackbar('Sukses', 'Profil berhasil di update');
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print(e);
        }
        Get.snackbar('Terjadi Kesalahan', 'Gagal update data');
      }
    } else {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Field input tidak boleh ada yang kosong!',
      );
    }
  }
}
