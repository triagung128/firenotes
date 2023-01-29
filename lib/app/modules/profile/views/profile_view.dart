import 'dart:io';

import 'package:firenotes/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/image_profile.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(
              Icons.logout,
              size: 28,
              color: darkBlackColor,
            ),
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
              child: Text('No Data'),
            );
          } else {
            controller.emailC.text = snapshot.data!['email'];
            controller.nameC.text = snapshot.data!['name'];
            controller.phoneC.text = snapshot.data!['phone'];

            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Email',
                  style: captionTextStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  snapshot.data!['email'],
                  style: titleTextStyle,
                ),
                const SizedBox(height: 21),
                Text(
                  'Name',
                  style: captionTextStyle,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.nameC,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  style: formTextStyle,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: formTextStyle.copyWith(
                      color: lightBlackColor.withOpacity(0.3),
                    ),
                  ),
                ),
                const SizedBox(height: 21),
                Text(
                  'Phone',
                  style: captionTextStyle,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.phoneC,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  style: formTextStyle,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    hintStyle: formTextStyle.copyWith(
                      color: lightBlackColor.withOpacity(0.3),
                    ),
                  ),
                ),
                const SizedBox(height: 21),
                Text(
                  'Created At : ',
                  style: captionTextStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('dd MMMM y H:mm WIB').format(
                    DateTime.parse(snapshot.data!['created_at']),
                  ),
                  style: titleTextStyle,
                ),
                const SizedBox(height: 21),
                Text(
                  'Image Profile : ',
                  style: captionTextStyle,
                ),
                const SizedBox(height: 8),
                GetBuilder<ProfileController>(
                  builder: (c) {
                    return Row(
                      children: [
                        c.image != null
                            ? ImageProfile(
                                imageProvider: FileImage(
                                  File(c.image!.path),
                                ),
                              )
                            : snapshot.data?['img_profile'] != null
                                ? ImageProfile(
                                    imageProvider: NetworkImage(
                                      snapshot.data!['img_profile'],
                                    ),
                                  )
                                : const Text('No Profile Image'),
                        const SizedBox(width: 24),
                        TextButton(
                          onPressed: () => c.imagePicker(),
                          child: Text(
                            'Select Image',
                            style: bodyTextStyle.copyWith(
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 60),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.isTrue
                        ? null
                        : () => controller.updateProfile(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      textStyle: buttonTextStyle,
                      backgroundColor: secondaryColor,
                    ),
                    child: Text(
                      controller.isLoading.isFalse
                          ? 'Update Profile'
                          : 'Loading...',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.changePassword),
                  child: Text(
                    'Change Password',
                    style: bodyTextStyle.copyWith(color: secondaryColor),
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
