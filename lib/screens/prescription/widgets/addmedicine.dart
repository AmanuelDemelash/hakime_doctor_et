
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakime_doctor_et/controllers/doctor_controllers/writeprescriptioncontroller.dart';
import 'package:hakime_doctor_et/screens/prescription/model/pmedcine.dart';

import '../../../utils/constants.dart';
class Addmedicine extends StatelessWidget {
   Addmedicine({Key? key}) : super(key: key);

  final _formkey=GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(15),
        child:  Stack(
          children: [
            SizedBox(
              height: Get.height/1.1,
              child: Column(
                children:[
                  const SizedBox(height: 10,),
                  const  Text("Add medicine",style: TextStyle(color: Colors.black54),),
                  const SizedBox(height:100,),
                  Form(
                      key: _formkey,
                      child:Column(
                        children: [
                          TextFormField(
                            controller: Get.find<WritrprescriptionController>().mname,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == "") {
                                return customsnack("name is empity");
                              } else if (!RegExp(
                                  "^[a-zA-Z]")
                                  .hasMatch(value!)) {
                                return customsnack("Please enter valid name");
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "medicine name",
                                filled: true,
                                contentPadding: const EdgeInsets.all(15),
                                prefixIcon: const Icon(Icons.medication_rounded),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                border: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Constants.primcolor),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        Constants.primcolor.withOpacity(0.2)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                fillColor: Colors.white),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: Get.find<WritrprescriptionController>().mstrength,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == "") {
                                return customsnack("Strength is empity");
                              } else if (!RegExp(
                                  "^[a-zA-Z]")
                                  .hasMatch(value!)) {
                                return customsnack("Please enter valid Strength");
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Strength mm/ ml ",
                                filled: true,
                                contentPadding: const EdgeInsets.all(15),
                                prefixIcon: const Icon(Icons.power),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                border: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Constants.primcolor),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        Constants.primcolor.withOpacity(0.2)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                fillColor: Colors.white),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: Get.find<WritrprescriptionController>().mstrength,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == "") {
                                return customsnack("frequency is empty");
                              } else if (!RegExp(
                                  "^[a-zA-Z]")
                                  .hasMatch(value!)) {
                                return customsnack("Please enter valid frequency");
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Frequency ",
                                filled: true,
                                contentPadding: const EdgeInsets.all(15),
                                prefixIcon: const Icon(Icons.calendar_view_day),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                border: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Constants.primcolor),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        Constants.primcolor.withOpacity(0.2)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                fillColor: Colors.white),
                          ),
                          const SizedBox(height: 60,),
                          // add medicine
                          Container(
                            width: Get.width,
                            height: 50,
                            margin:const EdgeInsets.only(left: 10,right: 10),
                            decoration:const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: ElevatedButton(
                                onPressed:() {
                                  _formkey.currentState!.save();
                                  if(Get.find<WritrprescriptionController>().mname.text.isEmpty || Get.find<WritrprescriptionController>().mstrength.text.isEmpty){
                                    customsnack("please enter valid medicine information");
                                  }else{
                                    Pmedicine medicin= Pmedicine(
                                        name: Get.find<WritrprescriptionController>().mname.text,
                                        strength: Get.find<WritrprescriptionController>().mstrength.text
                                    );
                                    Get.find<WritrprescriptionController>().addmedicine(medicin);
                                    Get.find<WritrprescriptionController>().clearallinput();
                                    Get.back();

                                  }
                                },
                                child:const Text("Add medicine",style: TextStyle(color: Colors.white),)),

                          )
                        ],
                      ))
                  // name

                ],
              ),
            ),
            Positioned(
              top: 1,
              right:1,
              child:
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Constants.primcolor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.cancel),
                ),
              ),
            ),

          ],
        )

    );
  }
}
