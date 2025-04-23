import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logiology_machinetest/features/auth/model/usermodel.dart';
import 'package:logiology_machinetest/features/home/presentation/view/home_screen.dart';
import 'package:logiology_machinetest/general/utils/firebase_collection.dart';

class AuthController extends GetxController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final GetStorage storage = GetStorage();

  // AUTH CONTROLLERS
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  var isLoading = false.obs;
  Rxn<Usermodel> loggedInUser = Rxn<Usermodel>();

  Future<void> login() async {
    isLoading.value = true;

    try {
      var userQuery =
          await fireStore
              .collection(FirebaseCollection.users)
              .where('username', isEqualTo: username.text.trim())
              .where('password', isEqualTo: password.text.trim())
              .get();

      if (userQuery.docs.isNotEmpty) {
        var doc = userQuery.docs.first;
        var user = Usermodel.fromMap(doc.data());
        loggedInUser.value = user;

        // ✅ Save fetched user data to GetStorage
        storage.write('username', user.username);
        storage.write('password', user.password);
        storage.write('profile_image', user.profileImgurl);

        Get.snackbar("Success", "Login successful");
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Error", "Invalid username or password");
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
