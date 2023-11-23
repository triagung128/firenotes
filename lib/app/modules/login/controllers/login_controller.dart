import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final String rememberMeKey = 'REMEMBER ME KEY';

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage box = GetStorage();

  RxBool isLoading = false.obs;
  RxBool isRememberMe = false.obs;

  void login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        debugPrint(userCredential.toString());

        if (userCredential.user!.emailVerified == true) {
          if (box.read(rememberMeKey) != null) {
            await box.remove(rememberMeKey);
          }

          if (isRememberMe.isTrue) {
            await box.write(rememberMeKey, {
              'email': emailC.text,
              'password': passwordC.text,
            });
          }

          isLoading.value = false;
          Get.offAllNamed(Routes.home);
        } else {
          isLoading.value = false;
          debugPrint('User not verified!');

          Get.defaultDialog(
            title: 'Your account is not verified',
            middleText: 'Do you want to send the verification email again?',
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // kirim ulang email verifikasi
                    await userCredential.user!.sendEmailVerification();
                    Get.back();
                    debugPrint('Successfully sent verification email');
                    Get.snackbar(
                      'Success',
                      'We have sent a verification email. Check your email!',
                    );
                  } on FirebaseAuthException catch (e) {
                    Get.back();
                    if (e.code == 'too-many-requests') {
                      Get.snackbar(
                        'Error',
                        'Failed to send verification email!',
                      );
                    }
                  }
                },
                child: const Text('Send Again'),
              ),
            ],
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        debugPrint(e.code);
        Get.snackbar('Error', e.code);
      }
    } else {
      Get.snackbar('Warning', 'The input field cannot be empty!');
    }
  }
}
