import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => TextField(
              controller: controller.passwordC,
              autocorrect: false,
              obscureText: controller.isPasswordHidden.isTrue ? true : false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => controller.isPasswordHidden.toggle(),
                  icon: Icon(
                    controller.isPasswordHidden.isTrue
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.toNamed(Routes.resetPassword),
                child: const Text('Forgot Password ?'),
              ),
            ],
          ),
          Obx(
            () => ElevatedButton(
              onPressed:
                  controller.isLoading.isTrue ? null : () => controller.login(),
              child: Text(
                controller.isLoading.isFalse ? 'Login' : 'Loading...',
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.register),
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
