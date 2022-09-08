import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text('Tidak ada data'),
            );
          } else {
            controller.emailC.text = snapshot.data!['email'];
            controller.nameC.text = snapshot.data!['name'];
            controller.phoneC.text = snapshot.data!['phone'];
            String createdAt = snapshot.data!['created_at'];

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextField(
                  readOnly: true,
                  enabled: false,
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
                TextField(
                  controller: controller.nameC,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controller.phoneC,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Created At : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  DateFormat('dd MMMM y H:mm WIB').format(
                    DateTime.parse(createdAt),
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.isTrue
                        ? null
                        : () => controller.updateProfile(),
                    child: Text(
                      controller.isLoading.isFalse
                          ? 'Update Profile'
                          : 'Loading...',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.changePassword),
                  child: const Text('Change Password'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
