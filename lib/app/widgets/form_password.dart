import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPassword extends StatelessWidget {
  const FormPassword({
    Key? key,
    required this.textEditingController,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    RxBool isHidden = true.obs;

    return Obx(
      () => TextField(
        controller: textEditingController,
        autocorrect: false,
        obscureText: isHidden.isTrue ? true : false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
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
