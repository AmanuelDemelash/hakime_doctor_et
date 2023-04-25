import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dprofilecontroller extends GetxController {
  var is_edit_profile = false.obs;
  var speciality_id = 0.obs;
  var is_experiance_add = false.obs;
  var is_experiance_deleted = false.obs;

  Rx<bool> is_aproved = false.obs;

  // packags
  var video = false.obs;
  var voice = false.obs;
  var chat = false.obs;

  customsnack(String message) {
    return Get.snackbar("Error", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));
  }
}
