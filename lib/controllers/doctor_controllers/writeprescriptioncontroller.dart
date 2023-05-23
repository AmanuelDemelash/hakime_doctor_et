
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/prescription/model/pmedcine.dart';
import 'dart:typed_data';
class WritrprescriptionController extends GetxController{

  var isSendPrescrip=false.obs;

   TextEditingController mname=TextEditingController();
   TextEditingController mstrength=TextEditingController();
   var dose="g".obs;

   Rx<String> medicin_search_key = "".obs;

   Rx<List<Pmedicine>> medicines=Rx<List<Pmedicine>>([]);
   Rx<List<Map<String,String>>> medcinArray=Rx<List<Map<String,String>>>([]);

   ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);
   // add medicine

  Future<void> addmedicine(Pmedicine medcine)async{
     medicines.value.add(medcine);
     update();
  }

   Future<void> removiemedicine(int index)async{
     medicines.value.removeAt(index);
     medcinArray.value.removeAt(index);
     update();
   }

   Future<void> clearallinput()async{
     mname.clear();
     mstrength.clear();
     update();
   }

  customSnackErr(String message) {
    return Get.snackbar("Error", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));
  }

  customSnackSuccs(String message) {
    return Get.snackbar("Success", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));
  }


}