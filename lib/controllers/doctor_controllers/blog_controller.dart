import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File> image = Rx<File>(File(""));
  var is_image = false.obs;
  var tubnil_picture_base64 = "".obs;

  var is_posting = false.obs;

  Future<void> get_tubnail() async {
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      is_image.value = true;
      image.value = File(selectedImage.path);
      Uint8List imgbytes = await image.value.readAsBytes();
      tubnil_picture_base64.value = base64.encode(imgbytes);
      update();
    }
  }
}
