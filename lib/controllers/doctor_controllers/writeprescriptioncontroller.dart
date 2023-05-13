
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../screens/prescription/model/pmedcine.dart';

class WritrprescriptionController extends GetxController{

   TextEditingController mname=TextEditingController();
   TextEditingController mstrength=TextEditingController();

   Rx<List<Pmedicine>> medicines=Rx<List<Pmedicine>>([]);


   // add medicine

  Future<void> addmedicine(Pmedicine medcine)async{
     medicines.value.add(medcine);
     update();
  }

}