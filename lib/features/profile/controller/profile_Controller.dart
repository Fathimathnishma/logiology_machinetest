import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology_machinetest/features/auth/model/usermodel.dart';
import 'package:logiology_machinetest/general/utils/firebase_collection.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //PROFILE UPDATE CONTROLLERS

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  var isLoading = false.obs;
  var profileImgUrl = "".obs;

  void showImageSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(source: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage({required ImageSource source}) async {
    isLoading.value = true;
    update();

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Save image locally
      String localPath = await saveImageLocally(imageFile);

      // Save the local path
      profileImgUrl.value = localPath;
    } else {
      Get.snackbar("Cancelled", "No image selected");
    }

    isLoading.value = false;
    update();
  }

  Future<String> saveImageLocally(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/profile_image.jpg'; // Save as .jpg or other extension

    // Copy the image file to the app's document directory
    await imageFile.copy(path);

    return path;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;

    try {
      final userRef = fireStore
          .collection(FirebaseCollection.users)
          .doc(FirebaseCollection.userId);

      final docSnapshot = await userRef.get();
      if (!docSnapshot.exists) {
        Get.snackbar("Error", "User not found");
        isLoading.value = false;
        return;
      }

      // Create updated user model
      Usermodel updatedUser = Usermodel(
        username: username.text.trim(),
        password: password.text.trim(),
        profileImgurl: profileImgUrl.value,
      );

      await userRef.update(updatedUser.toMap());

      Get.snackbar("Success", "Profile updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
