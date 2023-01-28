import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../../../widgets/form_password.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxRead = controller.box.read(controller.rememberMeKey);
    if (boxRead != null) {
      controller.emailC.text = boxRead['email'];
      controller.passwordC.text = boxRead['password'];
      controller.isRememberMe.value = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firenotes'),
        titleTextStyle: appBarTextStyle,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 16,
        ),
        children: [
          const SizedBox(height: 46),
          Text(
            'Login',
            style: headTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 52),
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
          const SizedBox(height: 21),
          Text(
            'Password',
            style: captionTextStyle,
          ),
          const SizedBox(height: 8),
          FormPassword(
            controller: controller.passwordC,
            hintText: 'Input Password',
          ),
          const SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isRememberMe.value,
                      onChanged: (_) => controller.isRememberMe.toggle(),
                    ),
                  ),
                  Text(
                    'Remember Me',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.resetPassword),
                child: Text(
                  'Forgot Password?',
                  style: bodyTextStyle.copyWith(color: secondaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Obx(
            () => ElevatedButton(
              onPressed:
                  controller.isLoading.isTrue ? null : () => controller.login(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24),
                textStyle: buttonTextStyle,
                backgroundColor: secondaryColor,
              ),
              child:
                  Text(controller.isLoading.isFalse ? 'Login' : 'Loading...'),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Get.offNamed(Routes.register),
            child: Text(
              'Register',
              style: bodyTextStyle.copyWith(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
