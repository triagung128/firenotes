import 'package:firenotes/app/widgets/form_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          FormPassword(
            textEditingController: controller.passwordC,
            labelText: 'Password',
          ),
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
                  const Text('Remember Me'),
                ],
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.resetPassword),
                child: const Text('Forgot Password?'),
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
