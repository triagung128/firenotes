import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailC = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  void errMsg(String msg) {
    Get.snackbar('Error', msg);
  }

  void resetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        await _auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;

        Get.back();
        Get.snackbar(
          'Success',
          'We have sent a link to reset your password to your email',
        );
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg(e.code);
      } catch (e) {
        isLoading.value = false;
        errMsg('Failed to reset password to this email.');
      }
    } else {
      errMsg('Email has not been filled in!');
    }
  }
}
