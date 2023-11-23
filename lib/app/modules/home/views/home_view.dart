import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Notes'),
        titleTextStyle: appBarTextStyle2,
        leading: IconButton(
          onPressed: () => Get.toNamed(Routes.profile),
          icon: Image.asset(
            'assets/icons/align_left.png',
            height: 20,
            width: 20,
          ),
        ),
        // actions: [
        //   StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        //     stream: controller.streamProfile(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return CircleAvatar(
        //           backgroundColor: Colors.grey[300],
        //         );
        //       }

        //       final data = snapshot.data!.data();
        //       return GestureDetector(
        //         onTap: () => Get.toNamed(Routes.profile),
        //         child: CircleAvatar(
        //           backgroundColor: Colors.grey[300],
        //           backgroundImage: NetworkImage(
        //             data?['img_profile'] != null
        //                 ? data!['img_profile']
        //                 : 'https://ui-avatars.com/api/?name=${data?['name']}',
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        //   const SizedBox(
        //     width: 8.0,
        //   ),
        // ],
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

          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: snapshot.data!.docs.length,
            padding: const EdgeInsets.all(22),
            itemBuilder: (context, index) {
              final docNote = snapshot.data!.docs[index];
              final note = docNote.data();

              return Material(
                color: whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () => Get.toNamed(
                    Routes.editNote,
                    arguments: docNote.id,
                  ),
                  onLongPress: () => controller.deleteNote(docNote.id),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${note['title']}',
                          style: titleTextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${note['description']}',
                          style: bodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
              // return ListTile(
              //   onTap: () => Get.toNamed(
              //     Routes.editNote,
              //     arguments: docNote.id,
              //   ),
              //   tileColor: whiteColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   contentPadding: EdgeInsets.all(16),
              //   minVerticalPadding: 8,
              //   title: Text(
              //     '${note['title']}',
              //     style: titleTextStyle,
              //   ),
              //   subtitle: Text(
              //     '${note['description']}',
              //     style: bodyTextStyle,
              //   ),
              //   trailing: IconButton(
              //     onPressed: () => controller.deleteNote(docNote.id),
              //     icon: const Icon(Icons.delete),
              //   ),
              // );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () => Get.toNamed(Routes.addNote),
        child: const Icon(Icons.add),
      ),
    );
  }
}
