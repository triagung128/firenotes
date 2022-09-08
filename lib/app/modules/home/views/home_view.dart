import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
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
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                  backgroundColor: Colors.grey[300],
                );
              }

              final data = snapshot.data!.data();
              return GestureDetector(
                onTap: () => Get.toNamed(Routes.profile),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(
                    data?['img_profile'] != null
                        ? data!['img_profile']
                        : 'https://ui-avatars.com/api/?name=${data?['name']}',
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 8.0,
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
              child: Text('Data is empty'),
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
