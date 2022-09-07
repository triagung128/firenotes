import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  void errorMsg(String msg) {
    Get.snackbar('Terjadi Kesalahan', msg);
  }

  void register() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passwordC.text.trim(),
        );

        if (kDebugMode) {
          print(userCredential);
        }
        isLoading.value = false;

        // kirim link email verification
        await userCredential.user!.sendEmailVerification();

        Get.offAllNamed(Routes.login);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;

        if (kDebugMode) {
          print(e.code);
        }

        errorMsg(e.code);
      } catch (e) {
        isLoading.value = false;

        if (kDebugMode) {
          print(e);
        }

        errorMsg(e.toString());
      }
    } else {
      errorMsg('Email & Password harus diisi');
    }
  }
}
