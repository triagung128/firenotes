import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        titleTextStyle: appBarTextStyle2,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset(
            'assets/icons/arrow_left.png',
            height: 20,
            width: 12,
          ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.addNote(),
              icon: const Icon(
                Icons.save_as,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: controller.titleC,
            autocorrect: false,
            minLines: 1,
            maxLines: null,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            style: formTitleTextStyle,
            decoration: InputDecoration.collapsed(
              hintText: 'Title',
              hintStyle: formTitleTextStyle.copyWith(
                color: darkBlackColor.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.descriptionC,
            autocorrect: false,
            minLines: 5,
            maxLines: null,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: formDescriptionTextStyle,
            decoration: InputDecoration.collapsed(
              hintText: 'Description',
              hintStyle: formDescriptionTextStyle.copyWith(
                color: lightBlackColor.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Obx(
      //   () => Container(
      //     margin: const EdgeInsets.all(24),
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         padding: const EdgeInsets.symmetric(vertical: 24),
      //         textStyle: buttonTextStyle,
      //         backgroundColor: secondaryColor,
      //       ),
      //       onPressed:
      //           controller.isLoading.isTrue ? null : () => controller.addNote(),
      //       child: Text(controller.isLoading.isFalse ? 'Save' : 'Loading...'),
      //     ),
      //   ),
      // ),
    );
  }
}
