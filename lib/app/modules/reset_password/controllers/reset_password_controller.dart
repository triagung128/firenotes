import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailC = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  void errMsg(String msg) {
    Get.snackbar('Terjadi Kesalahan', msg);
  }

  void resetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        await _auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;

        Get.back();
        Get.snackbar(
          'Berhasil',
          'Kami telah mengirimkan link untuk reset password ke email Anda!',
        );
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg(e.code);
      } catch (e) {
        isLoading.value = false;
        errMsg('Tidak dapat reset password ke email ini.');
      }
    } else {
      errMsg('Email belum diisi!');
    }
  }
}
