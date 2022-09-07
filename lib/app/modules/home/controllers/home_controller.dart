import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar('Terjadi Kesalahan', 'Tidak dapat logout');
    }
  }
}
