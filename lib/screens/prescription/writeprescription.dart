import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import '../../controllers/doctor_controllers/writeprescriptioncontroller.dart';
import '../../utils/constants.dart';

class WritePrescription extends StatelessWidget {
  Map<String, dynamic> data = Get.arguments;
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
      threshold: 3.0, smoothRatio: 0.65, velocityRange: 2.0);

  Widget _buildImageView() => Container(
        width: 180.0,
        height: 80.0,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white30,
        ),
        child: ValueListenableBuilder<ByteData?>(
          valueListenable: Get.find<WritrprescriptionController>().rawImageFit,
          builder: (context, data, child) {
            if (data == null) {
              return Container(
                color: Colors.red,
                child: const Center(
                  child: Text('not signed yet (png)\nscaleToFill: false'),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(
                  data.buffer.asUint8List(),
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
        ),
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        title: const Text(
          "Write prescription",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.find<WritrprescriptionController>().medicines.value.clear();
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )
        ),
      ),
      body:
     Stack(
       children: [
         Container(
           width: Get.width,
           height: 40,
           decoration:const BoxDecoration(
             color: Constants.primcolor,
             borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(20),
               bottomRight: Radius.circular(20)
             )
           ),
         ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Expanded(
               child: SizedBox(
                 width: Get.width,
                 child: SingleChildScrollView(
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
                               padding: EdgeInsets.all(10),
                               child: Text(
                                 "Patient",
                                 style: TextStyle(fontWeight: FontWeight.bold),
                               ),
                             ),
                             ListTile(
                               leading: const CircleAvatar(
                                 radius: 20,
                                 child: Icon(
                                   Icons.person,
                                   color: Constants.whitesmoke,
                                 ),
                               ),
                               title: Text(data["user_name"]),
                               subtitle: Column(
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
                         padding: const EdgeInsets.only(
                           left: 20,
                         ),
                         decoration:const BoxDecoration(
                             color: Colors.white,
                             borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 const Text("Medicine"),
                                 GestureDetector(
                                   onTap: () async {
                                     Get.toNamed("/addmedicin");
                                   },
                                   child: Container(
                                     width: 50,
                                     height: 50,
                                     decoration: BoxDecoration(
                                         color: Constants.primcolor.withOpacity(0.8),
                                         borderRadius: BorderRadius.circular(10)),
                                     child: const Center(
                                         child: FaIcon(
                                           FontAwesomeIcons.add,
                                           color: Colors.white,
                                         )),
                                   ),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 10,),
                             GetBuilder<WritrprescriptionController>(
                                 init: Get.find<WritrprescriptionController>(),
                                 builder: (controller) {
                                   if (controller.medicines.value.isEmpty) {
                                     return SizedBox(
                                       child: Center(
                                         child: Padding(
                                           padding:const EdgeInsets.all(8.0),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children:[
                                               Image.asset("assets/images/medicine.png",width: 50,height: 50,),
                                              const Text(
                                                 "please add medicine",
                                                 style: TextStyle(color: Colors.black54),
                                               ),
                                             ],
                                           ),
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
                                         margin: const EdgeInsets.only(bottom: 5,right: 10),
                                         decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius:
                                             BorderRadius.circular(15)),
                                         child: ListTile(
                                             leading: Text(
                                               "${index + 1}",
                                               style: const TextStyle(
                                                   color: Colors.black54),
                                             ),
                                             title: Text(controller
                                                 .medicines.value[index].name),
                                             subtitle: Text(controller
                                                 .medicines.value[index].strength),
                                             trailing: IconButton(
                                                 onPressed: () {
                                                   controller.removiemedicine(index);
                                                 },
                                                 icon: const FaIcon(
                                                   FontAwesomeIcons.trash,
                                                   color: Colors.red,
                                                 ))),
                                       );
                                     },
                                   );
                                 }),
                             const SizedBox(height: 10,),
                           ],
                         ),
                       ),
                       const SizedBox(
                         height: 30,
                       ),
                       // signiture
                       Padding(
                         padding: const EdgeInsets.all(15),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text("Signature"),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 const Text(
                                   "add your signature hear",
                                   style: TextStyle(color: Colors.black54),
                                 ),
                                 GestureDetector(
                                     onTap: () => control.clear(),
                                     child: const Text(
                                       "Clear",
                                       style: TextStyle(color: Colors.red),
                                     )),
                               ],
                             ),
                           ],
                         ),
                       ),
                       Container(
                         width: Get.width,
                         margin: const EdgeInsets.only(left: 20, right: 20),
                         height: 140,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(15),
                         ),
                         child: HandSignature(
                           control: control,
                           color: Constants.primcolor,
                           type: SignatureDrawType.shape,
                           width: 3,
                         ),
                       ),
                       const SizedBox(
                         height: 30,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             // submit
             AnimatedContainer(
               duration: const Duration(seconds: 10),
               width: Get.width,
               height: 50,
               margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   // view prescription
                   SizedBox(
                     width: 180,
                     height: 60,
                     child: ElevatedButton(
                         onPressed: () async {
                           Get.find<WritrprescriptionController>()
                               .rawImageFit
                               .value = await control.toImage(
                             color: Colors.black,
                             background: Colors.greenAccent,
                             fit: true,
                           );
                           if (Get.find<WritrprescriptionController>()
                               .medicines
                               .value
                               .isEmpty) {
                             customsnack("empty medicine");
                           } else if (Get.find<WritrprescriptionController>()
                               .rawImageFit
                               .value ==
                               null) {
                             customsnack("please provide your signature");
                           } else {
                             Get.find<WritrprescriptionController>()
                                 .rawImageFit
                                 .value = await control.toImage(
                               color: Colors.black,
                               background: Colors.greenAccent,
                               fit: true,
                             );
                             // show prescription
                             showDialog(
                                 context: context,
                                 builder: (context) {
                                   return AlertDialog(
                                     title: Column(
                                       children: [
                                         Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment.end,
                                           children: [
                                             GestureDetector(
                                                 onTap: () {
                                                   Get.back();
                                                 },
                                                 child: const FaIcon(
                                                   FontAwesomeIcons.multiply,
                                                   color: Constants.primcolor,
                                                 ))
                                           ],
                                         ),
                                         Image.asset(
                                           "assets/images/logo.png",
                                           width: 60,
                                           height: 60,
                                         ),
                                         const Text(
                                           "Hakime",
                                           style: TextStyle(
                                               color: Constants.primcolor,
                                               fontSize: 14),
                                         ),
                                       ],
                                     ),
                                     content: Container(
                                       padding: const EdgeInsets.all(5),
                                       decoration: const BoxDecoration(
                                         color: Colors.white,
                                       ),
                                       child: SingleChildScrollView(
                                         child: Column(
                                           crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                           children: [
                                             const Text(
                                               "Patient information",
                                               style: TextStyle(
                                                   color: Constants.primcolor),
                                             ),
                                             const SizedBox(height: 10),
                                             Row(
                                               children: [
                                                 const Text(
                                                   "Name :",
                                                   style: TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                                 Text(
                                                   data["user_name"],
                                                   style: const TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                               ],
                                             ),
                                             Row(
                                               children: [
                                                 const Text(
                                                   "Sex :",
                                                   style: TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                                 Text(
                                                   data["user_sex"],
                                                   style:const TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                               ],
                                             ),
                                             Row(
                                               children: [
                                                 const Text(
                                                   "Phone :",
                                                   style: TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                                 Text(
                                                   data["user_phone"],
                                                   style: const TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                               ],
                                             ),
                                             // medicine
                                             const SizedBox(
                                               height: 30,
                                             ),
                                             const Text("Medicine information",
                                                 style: TextStyle(
                                                     color: Constants.primcolor)),
                                             const SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.spaceBetween,
                                               children: const [
                                                 Text(
                                                   "Name",
                                                   style: TextStyle(
                                                       color: Colors.black54),
                                                 ),
                                                 Text(
                                                   "Amount",
                                                   style: TextStyle(
                                                       color: Colors.black54),
                                                 )
                                               ],
                                             ),
                                             const SizedBox(height: 10),
                                             SizedBox(
                                                 width: Get.width,
                                                 child: Column(
                                                   children: List.generate(
                                                       Get.find<
                                                           WritrprescriptionController>()
                                                           .medicines
                                                           .value
                                                           .length,
                                                           (index) => Row(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment
                                                             .spaceBetween,
                                                         children: [
                                                           Text(Get.find<
                                                               WritrprescriptionController>()
                                                               .medicines
                                                               .value[index]
                                                               .name),
                                                           Text(Get.find<
                                                               WritrprescriptionController>()
                                                               .medicines
                                                               .value[index]
                                                               .strength)
                                                         ],
                                                       )),
                                                 )),
                                             const SizedBox(
                                               height: 30,
                                             ),
                                             Text(
                                                 "Date: ${DateTime.now().toString().substring(0, 10)}"),
                                             const SizedBox(height: 10),
                                             const Text("Doctor information",
                                                 style: TextStyle(
                                                     color: Constants.primcolor)),
                                             const SizedBox(height: 10),
                                             ListTile(
                                               leading: CircleAvatar(
                                                 radius: 15,
                                                 backgroundImage:
                                                 NetworkImage(data["doc_img"]),
                                               ),
                                               title: Text(data["doc_name"]),
                                               subtitle: Text(
                                                   "Speciality : ${data["doc_sep"]}"),
                                             ),
                                             // signiture
                                             const SizedBox(height: 10),
                                             const Text("Signature",
                                                 style: TextStyle(
                                                     color: Constants.primcolor)),
                                             _buildImageView(),
                                           ],
                                         ),
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
                   // send prescription
                   SizedBox(
                     width: 150,
                     height: 60,
                     child: ElevatedButton(
                         onPressed: () async {
                           Get.find<WritrprescriptionController>()
                               .rawImageFit
                               .value = await control.toImage(
                             color: Colors.black,
                             background: Colors.greenAccent,
                             fit: true,
                           );
                           if (Get.find<WritrprescriptionController>()
                               .medicines
                               .value
                               .isEmpty) {
                             customsnack("empty medicine");
                           } else if (Get.find<WritrprescriptionController>()
                               .rawImageFit
                               .value ==
                               null) {
                             customsnack("please provide your signature");
                           } else{
                             Get.find<WritrprescriptionController>()
                                 .rawImageFit
                                 .value = await control.toImage(
                               color: Colors.black,
                               background: Colors.greenAccent,
                               fit: true,
                             );
                             showDialog(
                               context: context,
                               builder: (context) {
                                 return AlertDialog(
                                   title: const Text(
                                     "Are you sure?",
                                     style: TextStyle(fontSize: 18),
                                   ),
                                   content: const Text(
                                     "Do you want to send this prescription paper?",
                                     style: TextStyle(color: Colors.black54),
                                   ),
                                   icon:const FaIcon(FontAwesomeIcons.prescription),
                                   titleTextStyle:const TextStyle(color: Constants.primcolor),
                                   actionsAlignment: MainAxisAlignment.spaceBetween,
                                   actions: [
                                     TextButton(
                                         onPressed: ()async{
                                           Get.back();
                                         }, child: const Text("No")) ,
                                     TextButton(
                                         onPressed: () {}, child: const Text("Yes")),
                                   ],
                                 );
                               },
                             );
                           }

                         },
                         child: const Text(
                           "Send",
                           style: TextStyle(color: Colors.white),
                         )),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ],
     )
    );
  }
}
