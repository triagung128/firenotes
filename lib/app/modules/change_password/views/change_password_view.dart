import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../../../widgets/form_password.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        titleTextStyle: appBarTextStyle2,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset(
            'assets/icons/arrow_left.png',
            height: 20,
            width: 12,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Old Password',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          FormPassword(
            controller: controller.oldPassC,
            hintText: 'Old Password',
          ),
          const SizedBox(height: 21),
          Text(
            'New Password',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          FormPassword(
            controller: controller.newPassC,
            hintText: 'New Password',
          ),
          const SizedBox(height: 21),
          Text(
            'Confirm New Password',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          FormPassword(
            controller: controller.confirmNewPassC,
            hintText: 'Confirm New Password',
          ),
          const SizedBox(height: 80),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.changePassword(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24),
                textStyle: buttonTextStyle,
                backgroundColor: secondaryColor,
              ),
              child: Text(
                controller.isLoading.isFalse ? 'Change Password' : 'Loading...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
