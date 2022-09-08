import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  void register() async {
    if (nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passwordC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passwordC.text.trim(),
        );

        if (kDebugMode) print(userCredential);

        // kirim link email verification
        await userCredential.user!.sendEmailVerification();

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': nameC.text,
          'phone': phoneC.text,
          'email': emailC.text,
          'uid': userCredential.user!.uid,
          'created_at': DateTime.now().toIso8601String(),
        });

        isLoading.value = false;
        Get.offAllNamed(Routes.login);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (kDebugMode) print(e.code);
        Get.snackbar('Error', e.code);
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) print(e);
        Get.snackbar('Error', e.toString());
      }
    } else {
      Get.snackbar('Warning', 'The input field cannot be empty!');
    }
  }
}
