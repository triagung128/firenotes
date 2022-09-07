import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isRememberMe = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GetStorage box = GetStorage();

  final String rememberMeKey = 'REMEMBER ME KEY';

  void errorMsg(String msg) {
    Get.snackbar('Terjadi Kesalahan', msg);
  }

  void login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        if (kDebugMode) {
          print(userCredential);
        }
        isLoading.value = false;

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

          Get.offAllNamed(Routes.home);
        } else {
          if (kDebugMode) {
            print('User belum terverifikasi & tidak dapat login');
          }

          Get.defaultDialog(
            title: 'Belum Terverifikasi',
            middleText: 'Apakah kamu ingin mengirim email verifikasi kembali ?',
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // kirim ulang email verifikasi
                    await userCredential.user!.sendEmailVerification();
                    Get.back();
                    if (kDebugMode) {
                      print('Berhasil mengirim email verifikasi');
                    }
                    Get.snackbar(
                      'Sukses',
                      'Kami telah mengirimkan email verifikasi. Segera buka email Anda dan lakukan verifikasi!',
                    );
                  } on FirebaseAuthException catch (e) {
                    Get.back();
                    if (e.code == 'too-many-requests') {
                      errorMsg(
                        'Gagal mengirim email verifikasi. Silahkan ulangi kembali!',
                      );
                    }
                  }
                },
                child: const Text('Kirim Lagi'),
              ),
            ],
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;

        if (kDebugMode) {
          print(e.code);
        }

        errorMsg(e.code);
      }
    } else {
      errorMsg('Email & Password harus diisi');
    }
  }
}
