import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class EditNoteController extends GetxController {
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<Map<String, dynamic>?> getNoteById(String docId) async {
    try {
      final uid = _auth.currentUser!.uid;
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .collection('notes')
          .doc(docId)
          .get();
      return doc.data();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  void editNote(String docId) async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        final uid = _auth.currentUser!.uid;
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('notes')
            .doc(docId)
            .update({
          'title': titleC.text,
          'description': descriptionC.text,
        });
        Get.defaultDialog(
          title: 'Sukses',
          middleText: 'Data berhasil diupdate',
          textConfirm: 'Oke',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.offAllNamed(Routes.home),
        );
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) {
          print(e);
        }
        Get.snackbar('Terjadi Kesalahan', 'Gagal mengubah data');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Field input harus diisi!');
    }
  }
}
