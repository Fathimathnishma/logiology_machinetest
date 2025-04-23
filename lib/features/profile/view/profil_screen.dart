import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                        if (profileController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          ); // Show loading while picking image
                        }

                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.primaryColor,
                          backgroundImage:
                              profileController.profileImgUrl.value.isNotEmpty
                                  ? FileImage(
                                    File(profileController.profileImgUrl.value),
                                  ) // Load the image from local path
                                  : null,
                          child:
                              profileController.profileImgUrl.value.isEmpty
                                  ? Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ) // Default icon when no image is selected
                                  : null,
                        );
                      }),

                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jalla Jalal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '+91 9876543210',
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
                        child: Icon(Icons.edit),
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
                        Row(
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
                        Row(
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
                        SizedBox(height: 6),
                        CTextFormField(
                          controller: profileController.username,
                          height: 45,
                          borderRadius: 25,
                          labelText: "username",
                        ),
                        const SizedBox(height: 16),
                        Row(
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
                        SizedBox(height: 6),
                        CTextFormField(
                          controller: profileController.password,
                          height: 45,
                          borderRadius: 25,
                          labelText: "password",
                        ),
                        const SizedBox(height: 32),
                        Obx(
                          () =>
                              profileController.isLoading.value
                                  ? CircularProgressIndicator()
                                  : CustomButton(
                                    onTap: () {
                                      profileController.updateProfile();
                                    },
                                    buttontext: "Save",
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                  ),
                        ),
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
