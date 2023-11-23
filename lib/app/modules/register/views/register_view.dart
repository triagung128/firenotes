import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:firenotes/app/widgets/form_password.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/styles.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firenotes'),
        titleTextStyle: appBarTextStyle,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        children: [
          const SizedBox(height: 46),
          Text(
            'Create a free account',
            style: headTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            'Join Firenotes for free. Create and share\n unlimited notes with your friends.',
            style: bodyTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 52),
          Text(
            'Name',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Input Name',
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
          const SizedBox(height: 21),
          Text(
            'Phone',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.phoneC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Input Phone',
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
          const SizedBox(height: 21),
          Text(
            'Email',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
          const SizedBox(height: 21),
          Text(
            'Password',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          FormPassword(
            controller: controller.passwordC,
            hintText: 'Password',
          ),
          const SizedBox(height: 80),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.register(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24),
                textStyle: buttonTextStyle,
                backgroundColor: secondaryColor,
              ),
              child: Text(
                controller.isLoading.isFalse ? 'Register' : 'Loading...',
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Get.offNamed(Routes.login),
            child: Text(
              'Already have an account?',
              style: bodyTextStyle.copyWith(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
