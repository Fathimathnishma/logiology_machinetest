import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology_machinetest/general/utils/firebase_collection.dart';

class AuthController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //AUTH CONTROLLERS

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  var isLoading = false.obs;

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
        Get.snackbar("Success", "Login successful");
        // Navigate to home or dashboard
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
