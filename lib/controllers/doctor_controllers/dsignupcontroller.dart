import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class dsignupcontroller extends GetxController {
  var is_verifaying = false.obs;
  var intial_page = 0.obs;
  var password_visible = true.obs;
  var is_signup = false.obs;
  var accept_policy = false.obs;

  // doctor form
  var full_name = "".obs;
  var user_name = "".obs;
  var dateofbirth = "".obs;
  var sex = "".obs;
  var specility = 0.obs;
  var hospital = "".obs;
  var experiance_year = 0.obs;
  var email = "".obs;
  var password = "".obs;
  var phone = "".obs;
  var profile_pic = 0.obs;
  var cv = 0.obs;

  final ImagePicker _picker = ImagePicker();
  var profile_picture_base64 = "".obs;
  var cv_base64 = "".obs;
  var cv_file_name = "".obs;

  var is_image = false.obs;
  var is_cv = false.obs;
  var is_image_uploading = false.obs;
  var is_cv_uploading = false.obs;

  Rx<File> image = Rx<File>(File(""));
  Rx<File> cv_file = Rx<File>(File(""));

  var pagcontroller = PageController(initialPage: 0);

  Future<void> getprofile_image() async {
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      is_image.value = true;
      image.value = File(selectedImage.path);
      Uint8List imgbytes = await image.value.readAsBytes();
      profile_picture_base64.value = base64.encode(imgbytes);
      update();
      print(profile_picture_base64.value);
    }
  }

  Future<void> getdoctor_license() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'jpg', 'png'],
    );
    if (result != null) {
      cv_file.value = File(result.files.single.path!);
      is_cv.value = true;
      cv_file_name.value = result.files.single.name;
      Uint8List cvbytes = await cv_file.value.readAsBytes();
      cv_base64.value = base64.encode(cvbytes);
      update();
    } else {
      // User canceled the picker
    }
  }
}
