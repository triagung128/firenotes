import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firenotes/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firenotes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.profile),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
            return const Center(
              child: Text('Data kosong'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final docNote = snapshot.data!.docs[index];
              final note = docNote.data();
              return ListTile(
                onTap: () => Get.toNamed(
                  Routes.editNote,
                  arguments: docNote.id,
                ),
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text('${note['title']}'),
                subtitle: Text('${note['description']}'),
                trailing: IconButton(
                  onPressed: () => controller.deleteNote(docNote.id),
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.addNote),
        child: const Icon(Icons.add),
      ),
    );
  }
}
