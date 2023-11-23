import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPassC = TextEditingController();
  final TextEditingController newPassC = TextEditingController();
  final TextEditingController confirmNewPassC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  void changePassword() async {
    if (oldPassC.text.isNotEmpty &&
        newPassC.text.isNotEmpty &&
        confirmNewPassC.text.isNotEmpty) {
      isLoading.value = true;

      final user = _auth.currentUser!;
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassC.text,
      );

      try {
        await user.reauthenticateWithCredential(credential);
        await _auth.currentUser?.updatePassword(newPassC.text);

        isLoading.value = false;

        Get.back();
        Get.snackbar('Success', 'Your password has been successfully changed');
      } catch (e) {
        isLoading.value = false;
        debugPrint(e.toString());
        if (e.toString().contains('wrong-password')) {
          Get.snackbar('Error', 'Old password is wrong!');
        } else {
          Get.snackbar('Error', 'Failed to change password, try again later!');
        }
      }
    } else {
      Get.snackbar('Warning', 'The input field cannot be empty!');
    }
  }
}
