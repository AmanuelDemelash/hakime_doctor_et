
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_doctor_et/controllers/doctor_controllers/writeprescriptioncontroller.dart';
import 'package:hakime_doctor_et/screens/prescription/model/pmedcine.dart';

import '../../apiservice/myquery.dart';
import '../../utils/constants.dart';
import '../../widgets/cool_loading.dart';

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
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        title: const Text(
          "Add medicine",
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
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 50,
            decoration:const BoxDecoration(
                color: Constants.primcolor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ),

          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  margin:const EdgeInsets.all(10),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Form(
                      key: _formkey,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Please provide"),
                          const Text("Medicine and its dose",style: TextStyle(color: Colors.black54),),
                          const SizedBox(height:20,),
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
                            onChanged: (value) {
                              Get.find<WritrprescriptionController>().medicin_search_key.value=value;
                            },
                            decoration: InputDecoration(
                                hintText: "medicine name",
                                filled: true,
                                label:const Text("Name"),
                                labelStyle: const TextStyle(color: Constants.primcolor),
                                contentPadding: const EdgeInsets.all(20),
                                prefixIcon: const Icon(Icons.medication_rounded,color: Constants.primcolor,),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                border:const OutlineInputBorder(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
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
                                      label:const Text("Dose"),
                                      labelStyle: const TextStyle(color: Constants.primcolor),
                                      contentPadding: const EdgeInsets.all(20),
                                      prefixIcon: const Icon(Icons.power,color: Constants.primcolor,),
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
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                height: 60,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:Obx(() =>DropdownButton(
                                  underline:null,
                                  elevation: 0,
                                  style:const TextStyle(color: Constants.primcolor),
                                  dropdownColor: Colors.white,
                                  value:Get.find<WritrprescriptionController>().dose.value,
                                  items:const[
                                    DropdownMenuItem(value: "g",child: Text("gram(g)"),
                                    ),
                                    DropdownMenuItem(value: "mg",child: Text("milligram(mg)"),),
                                    DropdownMenuItem(value: "mcg",child: Text("micrograms(mcg)"),
                                    )
                                  ], onChanged:(value) {
                                  Get.find<WritrprescriptionController>().dose.value=value!;

                                },),),
                              )
                            ],
                          ),
                          const SizedBox(height: 50,),
                          // add medicineog
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
                                      strength: "${Get.find<WritrprescriptionController>().mstrength.text} ${Get.find<WritrprescriptionController>().dose.value}",
                                    );
                                    Get.find<WritrprescriptionController>().addmedicine(medicin);
                                    // add to medcin aarry for mutation
                                    Get.find<WritrprescriptionController>().medcinArray.value.add(
                                        {"medicine_name":Get.find<WritrprescriptionController>().mname.text,
                                          "dose":Get.find<WritrprescriptionController>().mstrength.text,
                                        }
                                    );
                                    Get.find<WritrprescriptionController>().clearallinput();
                                    Get.back();
                                  }
                                },
                                child:const Text("Add medicine",style: TextStyle(color: Colors.white),)),

                          )
                        ],
                      )),
                ),
                // list of all medicine
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:const [
                      Text("Medicines",style: TextStyle(color: Colors.black54),),
                      Text("see all",style: TextStyle(color: Colors.black54),)
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Obx(() =>
                    Query(
                        options:
                        Get.find<WritrprescriptionController>().medicin_search_key.value == ""
                            ? QueryOptions(
                          document: gql(Myquery.allmedicines),
                        )
                            : QueryOptions(
                            document: gql(Myquery.searchmed),
                            variables: {
                              "name":
                              "%${Get.find<WritrprescriptionController>().medicin_search_key.value}%"
                            }
                        ),
                        builder:(result, {fetchMore, refetch}){
                          if(result.hasException){
                            return const cool_loding();
                          }
                          if(result.isLoading){
                            return const cool_loding();
                          }
                          List medicines=result.data!["medicine"];
                          if(medicines.isEmpty){
                            return Text("no medicine found!");
                          }
                          return
                              ListView.builder(
                                physics:const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:medicines.length,
                                itemBuilder:(context, index) {
                                  return
                                    GestureDetector(
                                      onTap: () {
                                        Get.find<WritrprescriptionController>().mname.text=medicines[index]["name"];
                                        Get.find<WritrprescriptionController>().medicin_search_key.value="";
                                      },
                                      child:
                                          ListTile(
                                              leading:
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl:medicines[index]["medicine_image"]["url"],
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => const FaIcon(FontAwesomeIcons.image,color: Constants.primcolor,size: 15,),
                                                  errorWidget: (context, url, error) =>const Icon(Icons.error),
                                                ),),
                                              subtitle: Text(medicines[index]["description"],maxLines: 1,),
                                              title: Text(medicines[index]["name"])),
                                    );

                                },
                              )
                          ;
                        }
                    )
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
