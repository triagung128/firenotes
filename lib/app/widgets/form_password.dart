import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/styles.dart';

class FormPassword extends StatelessWidget {
  const FormPassword({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    RxBool isHidden = true.obs;

    return Obx(
      () => TextField(
        controller: controller,
        autocorrect: false,
        obscureText: isHidden.isTrue ? true : false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hintText,
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
          suffixIconColor: secondaryColor,
          suffixIcon: IconButton(
            onPressed: () => isHidden.toggle(),
            icon: Icon(
              isHidden.isTrue ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
