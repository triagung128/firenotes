import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class AddNoteController extends GetxController {
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  void addNote() async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        final uid = _auth.currentUser?.uid;
        await _firestore.collection('users').doc(uid).collection('notes').add({
          'title': titleC.text,
          'description': descriptionC.text,
          'created_at': DateTime.now().toIso8601String(),
        });
        isLoading.value = false;
        Get.defaultDialog(
          title: 'Sukses',
          middleText: 'Data berhasil disimpan',
          textConfirm: 'Oke',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.offAllNamed(Routes.home),
        );
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print(e);
        }
        Get.snackbar('Terjadi Kesalahan', 'Gagal menyimpan data');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Form input harus diisi!');
    }
  }
}
