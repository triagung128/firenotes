import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 16,
        ),
        children: [
          Text(
            'Email',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            style: formTextStyle,
            decoration: InputDecoration(
              hintText: 'Input Email',
              hintStyle: formTextStyle.copyWith(
                color: lightBlackColor.withOpacity(0.3),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 19,
                horizontal: 16,
              ),
              filled: true,
              fillColor: whiteColor,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.resetPassword(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24),
                textStyle: buttonTextStyle,
                backgroundColor: secondaryColor,
              ),
              child: Text(
                controller.isLoading.isFalse ? 'Reset Password' : 'Loading...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
