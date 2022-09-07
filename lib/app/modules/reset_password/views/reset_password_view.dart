import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
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
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.resetPassword(),
              child: Text(
                controller.isLoading.isFalse ? 'Login' : 'Loading...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
