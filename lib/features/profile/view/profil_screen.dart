import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logiology_machinetest/features/profile/controller/profile_Controller.dart';
import 'package:logiology_machinetest/general/utils/app_colors.dart';
import 'package:logiology_machinetest/general/widgets/CTextform_widget.dart';
import 'package:logiology_machinetest/general/widgets/custom_button.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  bool _isEditing = false;
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    final storage = GetStorage();

    // Load values from GetStorage
    profileController.profileImgUrl.value = storage.read('profile_image') ?? "";
    profileController.username.text = storage.read('username') ?? "";
    profileController.password.text = storage.read('password') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Obx(() {
                        return profileController.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.primaryColor,
                              backgroundImage:
                                  profileController
                                          .profileImgUrl
                                          .value
                                          .isNotEmpty
                                      ? FileImage(
                                        File(
                                          profileController.profileImgUrl.value,
                                        ),
                                      )
                                      : null,
                              child:
                                  profileController.profileImgUrl.value.isEmpty
                                      ? Icon(Icons.person, color: Colors.white)
                                      : null,
                            );
                      }),

                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileController.username.text.isNotEmpty
                                ? profileController.username.text
                                : 'UserName',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '+91 98*******10',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                        child: const Icon(Icons.edit),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          profileController.showImageSourcePicker(context);
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_isEditing)
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Edit profile',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Row(
                          children: [
                            Text(
                              " Enter new username",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        CTextFormField(
                          controller: profileController.username,
                          height: 45,
                          borderRadius: 25,
                          labelText: "username",
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Enter new password",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        CTextFormField(
                          controller: profileController.password,
                          height: 45,
                          borderRadius: 25,
                          labelText: "password",
                        ),
                        const SizedBox(height: 32),
                        Obx(() {
                          return profileController.isLoading.value
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                onTap: () {
                                  profileController.updateProfile();
                                },
                                buttontext: "Edit",
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                              );
                        }),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
