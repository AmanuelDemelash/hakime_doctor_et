import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hakime_doctor_et/screens/prescription/widgets/addmedicine.dart';
import 'package:hand_signature/signature.dart';
import '../../controllers/doctor_controllers/writeprescriptioncontroller.dart';
import '../../utils/constants.dart';

class WritePrescription extends StatelessWidget {


  Map<String,dynamic> data=Get.arguments;
  WritePrescription({Key? key}) : super(key: key);

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
  final control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        title: const Text(
          "Write prescription",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //patient
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Padding(
                    padding:  EdgeInsets.all(10),
                    child: Text("Patient",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  ListTile(
                    leading:const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person,color: Constants.whitesmoke,),
                    ),
                    title: Text(data["user_name"]),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data["user_sex"]),
                        Text(data["user_phone"]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // prescription form
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: Constants.primcolor.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Medicine"),
                  GestureDetector(
                    onTap: () async {
                      Get.bottomSheet(ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return  Addmedicine();
                          },
                        ),
                      ),
                        isScrollControlled: true
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Constants.primcolor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: FaIcon(
                        FontAwesomeIcons.add,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            // list of medicine
         AnimatedContainer(
           duration: const Duration(seconds: 10),
              width: Get.width,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)),
              child:GetBuilder<WritrprescriptionController>(
                init: Get.find<WritrprescriptionController>(),
                builder: (controller) {
                  if(controller.medicines.value.isEmpty){
                    return const SizedBox(
                      child:
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("please add medicine",style: TextStyle(color: Colors.black54),),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.medicines.value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(15)
                        ),
                        child: ListTile(
                            leading: Text("${index + 1}",style:const TextStyle(color: Colors.black54),),
                            title: Text(controller.medicines.value[index].name),
                            subtitle: Text(controller.medicines.value[index]
                                .strength),
                            trailing: IconButton(onPressed: () {
                              controller.removiemedicine(index);
                            },
                                icon: const FaIcon(
                                  FontAwesomeIcons.trash, color: Colors.red,))),
                      );
                    },
                  );
                }

              )
            ),

            const SizedBox(
              height:30,
            ),
         // signiture
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:const[
                   Text("Signature"),
                   Text("add your signature hear",style: TextStyle(color: Colors.black54),),
                ],
              ),
            ),
          Container(
         width: Get.width,
            margin:const EdgeInsets.only(left: 20,right: 20),
            height:140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child:HandSignature(
                      control: control,
                      color: Constants.primcolor,
                      type: SignatureDrawType.shape,
                      width:3,
                    ),
          ),
            const SizedBox(height: 30,),
            // submit
              AnimatedContainer(
                duration: const Duration(seconds: 10),
                width: Get.width,
                height: 50,
                margin:const EdgeInsets.only(left: 10, right: 10),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: ()async{
                            if(Get.find<WritrprescriptionController>().medicines.value.isEmpty){
                              customsnack("empty medicine");

                            }else{
                              showDialog(context: context, builder:(context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              Get.back();
                                },
                                              child: const FaIcon(FontAwesomeIcons.multiply,color: Constants.primcolor,))
                                        ],
                                      ),
                                      Image.asset("assets/images/logo.png",width: 60,height:60,),
                                      const Text("Hakime",style: TextStyle(color: Colors.black54),),

                                    ],),
                                  content: Container(
                                      padding:const EdgeInsets.all(5),
                                      decoration:const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         const Text("Patient information"),
                                          const SizedBox(height:10),
                                          Row(
                                            children: [
                                             const Text("Name :",style: TextStyle(color: Colors.black54),),
                                              Text(data["user_name"],style: TextStyle(color: Colors.black54),),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Sex :",style: TextStyle(color: Colors.black54),),
                                              Text(data["user_sex"],style: TextStyle(color: Colors.black54),),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Phone :",style: TextStyle(color: Colors.black54),),
                                              Text(data["user_phone"],style: const TextStyle(color: Colors.black54),),
                                            ],
                                          ),
                                          // medicine
                                          const SizedBox(height: 30,),
                                          const Text("Medicine information"),
                                          const SizedBox(height:10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:
                                            const[
                                              Text("Name",style: TextStyle(color: Colors.black54),),
                                              Text("Amount",style: TextStyle(color: Colors.black54),)
                                            ],
                                          ),
                                          const SizedBox(height:10),
                                          SizedBox(
                                            width: Get.width,
                                            child: Column(
                                              children:List.generate(Get.find<WritrprescriptionController>().medicines.value.length, (index) =>
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                 Text(Get.find<WritrprescriptionController>().medicines.value[index].name),
                                                 Text(Get.find<WritrprescriptionController>().medicines.value[index].strength)
                                               ],)
                                              ),
                                            )
                                          ),
                                          const SizedBox(height: 30,),
                                          
                                        ],

                                    ),
                                      ),
                                );
                            });
    }
                          },
                          child: const Text(
                            "View prescription",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Send",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),

            const SizedBox(height:20),

          ],
        ),
      ),
    );
  }
}
