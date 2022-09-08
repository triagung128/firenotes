import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        centerTitle: true,
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
              padding: const EdgeInsets.all(16.0),
              children: [
                TextField(
                  controller: controller.titleC,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: controller.descriptionC,
                  autocorrect: false,
                  minLines: 3,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.isTrue
                        ? null
                        : () => controller.editNote(Get.arguments.toString()),
                    child: Text(
                        controller.isLoading.isFalse ? 'Edit' : 'Loading...'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
