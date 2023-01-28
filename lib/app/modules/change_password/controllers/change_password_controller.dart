import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPassC = TextEditingController();
  final TextEditingController newPassC = TextEditingController();
  final TextEditingController confirmNewPassC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  void changePassword() async {
    _auth.currentUser?.updatePassword(newPassC.text);
  }
}
