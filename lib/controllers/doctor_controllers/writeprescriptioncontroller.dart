
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../screens/prescription/model/pmedcine.dart';
import 'dart:typed_data';
class WritrprescriptionController extends GetxController{

   TextEditingController mname=TextEditingController();
   TextEditingController mstrength=TextEditingController();
   Rx<List<Pmedicine>> medicines=Rx<List<Pmedicine>>([]);

   ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);
   // add medicine

  Future<void> addmedicine(Pmedicine medcine)async{
     medicines.value.add(medcine);
     update();
  }

   Future<void> removiemedicine(int index)async{
     medicines.value.removeAt(index);
     update();
   }

   Future<void> clearallinput()async{
     mname.clear();
     mstrength.clear();
     update();
   }



}