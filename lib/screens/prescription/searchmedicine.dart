
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_doctor_et/apiservice/myquery.dart';
import 'package:hakime_doctor_et/widgets/cool_loading.dart';

import '../../controllers/doctor_controllers/writeprescriptioncontroller.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';

class SearchMedicine extends StatelessWidget {
  const SearchMedicine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        title:const Text("Search Medicines",style: TextStyle(color: Colors.white),),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )
        ),
      ),
      body:
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height:120,
                padding:const EdgeInsets.all(15),
                decoration:const BoxDecoration(
                  color: Constants.primcolor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Center(
                      child: TextFormField(
                        autofocus: true,
                        controller: Get.find<WritrprescriptionController>().msearch,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == "") {
                            return null;
                          } else if (!RegExp(
                              "^[a-zA-Z]")
                              .hasMatch(value!)) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          Get.find<WritrprescriptionController>().medicin_search_key.value=value;
                          Get.find<WritrprescriptionController>().mname.text=value;
                        },
                        decoration: InputDecoration(
                            hintText: "medicine name",
                            filled: true,
                            contentPadding: const EdgeInsets.all(17),
                            prefixIcon: const Icon(Icons.search),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                            border:const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constants.primcolor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    Constants.primcolor.withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            fillColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height:5,),
            const  Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Search result",style: TextStyle(fontSize: 20),),
              ),
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
                    }),
                builder:(result, {fetchMore, refetch}){
                if(result.hasException){
                  return const cool_loding();
                }
                if(result.isLoading){
                  return const cool_loding();
                }
                List medicines=result.data!["medicine"];
                return Expanded(
                  child: ListView.separated(
                    padding:const EdgeInsets.all(15),
                      itemBuilder:(context, index) {
                    return 
                      GestureDetector(
                        onTap: () {
                          Get.find<WritrprescriptionController>().mname.text=medicines[index]["name"];
                          Get.find<WritrprescriptionController>().medicin_search_key.value="";
                          Get.find<WritrprescriptionController>().msearch.text="";
                          Get.back();
                        },
                        child: Container(
                          color: Colors.white54,
                          padding: const EdgeInsets.all(10),
                            child: Text(medicines[index]["name"])),
                      );

                  },
                  separatorBuilder:(context, index) => Divider(color: Constants.primcolor.withOpacity(0.3)),
                   itemCount:medicines.length),
                );
              },))
            ],
          ),
        ),

    );
  }
}
