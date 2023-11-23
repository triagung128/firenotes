import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                  : () => controller.editNote(Get.arguments.toString()),
              icon: const Icon(
                Icons.save_as,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getNoteById(Get.arguments.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text('Failed to get data!'),
            );
          } else {
            controller.titleC.text = snapshot.data!['title'];
            controller.descriptionC.text = snapshot.data!['description'];

            return ListView(
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
                const SizedBox(height: 16),
                TextField(
                  controller: controller.descriptionC,
                  autocorrect: false,
                  minLines: 1,
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
                // const SizedBox(height: 32.0),
                // Obx(
                //   () => ElevatedButton(
                //     onPressed: controller.isLoading.isTrue
                //         ? null
                //         : () => controller.editNote(Get.arguments.toString()),
                //     child: Text(
                //         controller.isLoading.isFalse ? 'Edit' : 'Loading...'),
                //   ),
                // ),
              ],
            );
          }
        },
      ),
    );
  }
}
