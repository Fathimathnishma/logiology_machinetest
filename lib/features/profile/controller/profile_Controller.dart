import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology_machinetest/features/auth/model/usermodel.dart';
import 'package:logiology_machinetest/general/utils/firebase_collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final storage = GetStorage();

  // Profile update controllers
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  var isLoading = false.obs;
  var profileImgUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    profileImgUrl.value = storage.read('profile_image') ?? "";
    log(
      "Controller initialized. Loaded image path from storage: ${profileImgUrl.value}",
    );
  }

  void showImageSourcePicker(BuildContext context) {
    log("Opening image source picker modal...");
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
                  log("Camera option selected");
                  pickImage(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  log("Gallery option selected");
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
    log("Image picking started. Source: ${source.toString()}");
    isLoading.value = true;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      log("Image picked: ${pickedFile.path}");

      File imageFile = File(pickedFile.path);
      String localPath = await saveImageLocally(imageFile);

      log("Image saved locally at: $localPath");

      // Update profile image URL
      profileImgUrl.value = localPath;
      log("profileImgUrl updated in controller: ${profileImgUrl.value}");

      // Save the new image path to GetStorage
      storage.write('profile_image', localPath);
      log("Image path written to GetStorage");
      isLoading.value = false;
      log("Image path written to GetStorage");
    } else {
      log("Image picking cancelled by user");
      isLoading.value = false;
      Get.snackbar("Cancelled", "No image selected");
    }
  }

  Future<String> saveImageLocally(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();

    // Generate a unique filename using UUID
    var uuid = Uuid();
    String uniqueFileName = uuid.v4(); // Generates a unique identifier
    final path = '${directory.path}/profile_image_$uniqueFileName.jpg';

    log("Saving image to: $path");

    await imageFile.copy(path);

    log("Image successfully saved at: $path");
    return path;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    log("Starting profile update...");

    try {
      final userRef = fireStore
          .collection(FirebaseCollection.users)
          .doc(FirebaseCollection.userId);

      final docSnapshot = await userRef.get();
      if (!docSnapshot.exists) {
        Get.snackbar("Error", "User not found");
        log("Error: User not found in Firestore");
        isLoading.value = false;
        return;
      }

      if (username.text.trim().isEmpty || password.text.trim().isEmpty) {
        Get.snackbar("Error", "Username and password cannot be empty");
        log("Error: Username or password is empty");
        isLoading.value = false;
        return;
      }

      Usermodel updatedUser = Usermodel(
        username: username.text.trim(),
        password: password.text.trim(),
        profileImgurl: profileImgUrl.value,
      );

      await userRef.update({
        'username': updatedUser.username,
        'password': updatedUser.password,
        'profileImgurl': updatedUser.profileImgurl,
      });

      log("Profile updated successfully in Firestore");
      Get.snackbar("Success", "Profile updated successfully");
    } catch (e) {
      log("Error during profile update: $e");
      Get.snackbar("Error", "Failed to update profile: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
