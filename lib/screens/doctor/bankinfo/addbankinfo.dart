import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../controllers/doctor_controllers/dbank_controller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';

class AddBankInfo extends StatelessWidget {
  AddBankInfo({super.key});

  var _formkey = GlobalKey<FormState>();
  TextEditingController banktype_controller = TextEditingController();
  TextEditingController accountnum_controller = TextEditingController();
  TextEditingController holdername_controller = TextEditingController();

  int doc_id = Get.find<SplashController>().prefs.getInt("id");

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
        title: const Text(
          "Bank information",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Provide your Bank Information!",
                style: TextStyle(fontSize: 28, color: Colors.black54),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // bank type
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: banktype_controller,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                } else {
                                  return null;
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Bank Type",
                                  enabled: false,
                                  filled: true,
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.whitesmoke),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.whitesmoke),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.whitesmoke),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.whitesmoke),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  fillColor: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15)),
                              child: PopupMenuButton(
                                icon: const FaIcon(FontAwesomeIcons.angleDown),
                                onSelected: (value) {
                                  banktype_controller.text = value.toString();
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                      value: "CBE",
                                      child:
                                          Text("Commercial bank of ethiopia")),
                                  PopupMenuItem(
                                      value: "Abysiniya Bank",
                                      child: Text("Abysiniya Bank")),
                                  PopupMenuItem(
                                      value: "Amhara Bank",
                                      child: Text("Amhara Bank"))
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Account number
                      TextFormField(
                        controller: accountnum_controller,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            customsnack("add account number");
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Account number",
                            enabled: true,
                            filled: true,
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Account number
                      TextFormField(
                        controller: holdername_controller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            customsnack("add bank holder name");
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Account holder name",
                            enabled: true,
                            filled: true,
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // button
                      Mutation(
                        options: MutationOptions(
                          document: gql(Mymutation.addbank_info),
                          onError: (error) {
                            customsnack(error.toString());
                            Get.find<DbankController>().is_bank_added.value =
                                false;
                          },
                          onCompleted: (data) {
                            Get.find<DbankController>().is_bank_added.value =
                                false;
                            Get.offNamed("/dbank");
                          },
                        ),
                        builder: (runMutation, result) {
                          if (result!.isLoading) {
                            Get.find<DbankController>().is_bank_added.value =
                                true;
                          }
                          return SizedBox(
                            width: Get.width,
                            child: Obx(() => ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(17)),
                                      onPressed: () {
                                        _formkey.currentState!.save();
                                        if (_formkey.currentState!.validate()) {
                                          if (banktype_controller
                                              .text.isEmpty) {
                                            customsnack("Add bank type");
                                          }
                                          Get.find<DbankController>()
                                              .is_bank_added
                                              .value = true;
                                          // run mutation
                                          runMutation({
                                            "doctor_id": doc_id,
                                            "bank_name":
                                                banktype_controller.text,
                                            "account_number":
                                                accountnum_controller.text,
                                            "full_name":
                                                holdername_controller.text
                                          });
                                        } else {
                                          customsnack("fill requird bank info");
                                        }
                                      },
                                      child: Get.find<DbankController>()
                                              .is_bank_added
                                              .value
                                          ? const ButtonSpinner()
                                          : const Text("Save")),
                                )),
                          );
                        },
                      )
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
