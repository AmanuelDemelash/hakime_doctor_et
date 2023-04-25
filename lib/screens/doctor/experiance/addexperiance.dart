import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../controllers/doctor_controllers/dprofilecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';

class AddExperiance extends StatelessWidget {
  AddExperiance({super.key});

  int id = Get.find<SplashController>().prefs.getInt("id");

  final _formkey = GlobalKey<FormState>();
  TextEditingController hospitalnamecontroller = TextEditingController();
  TextEditingController designattioncontroller = TextEditingController();
  TextEditingController departmentcontroller = TextEditingController();
  TextEditingController startcontroller = TextEditingController();
  TextEditingController endcontroller = TextEditingController();

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
          "Add Experiance",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Provide your Work experiance!",
                style: TextStyle(fontSize: 28, color: Colors.black54),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: hospitalnamecontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.find<dprofilecontroller>()
                                .customsnack("enter hospital name");
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Hospital Name",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "hospital name",
                            filled: true,
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: designattioncontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.find<dprofilecontroller>()
                                .customsnack("enter your designation");
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Designation",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "work position",
                            filled: true,
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: departmentcontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.find<dprofilecontroller>()
                                .customsnack("enter your department");
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Department",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "department",
                            filled: true,
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
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1978),
                                    lastDate: DateTime(2070));
                                startcontroller.text =
                                    "${date!.day}-${date.month}-${date.year}";
                              },
                              child: TextFormField(
                                controller: startcontroller,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    Get.find<dprofilecontroller>()
                                        .customsnack("enter start date");
                                  } else {
                                    return null;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    enabled: false,
                                    label: Text(
                                      "Start Date",
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    hintText: "start date",
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // end date
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1978),
                                    lastDate: DateTime(2070));
                                endcontroller.text =
                                    "${date!.day}-${date.month}-${date.year}";
                              },
                              child: TextFormField(
                                controller: endcontroller,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    Get.find<dprofilecontroller>()
                                        .customsnack("enter end date");
                                  } else {
                                    return null;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    label: Text(
                                      "End date",
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    enabled: false,
                                    hintText: "end date",
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
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Mutation(
                        options: MutationOptions(
                          document: gql(Mymutation.add_experiance),
                          onError: (error) {
                            Get.find<dprofilecontroller>()
                                .is_experiance_add
                                .value = false;
                            Get.find<dprofilecontroller>()
                                .customsnack(error.toString());
                          },
                          onCompleted: (data) {
                            Get.find<dprofilecontroller>()
                                .is_experiance_add
                                .value = false;
                            Get.offNamed("/dexperiance");
                          },
                        ),
                        builder: (runMutation, result) {
                          if (result!.isLoading) {
                            Get.find<dprofilecontroller>()
                                .is_experiance_add
                                .value = true;
                          }
                          return Container(
                            width: Get.width,
                            margin: const EdgeInsets.all(15),
                            child: Obx(() => ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    onPressed: () {
                                      _formkey.currentState!.save();
                                      if (_formkey.currentState!.validate()) {
                                        runMutation({
                                          "doctor_id": id,
                                          "hospital_name":
                                              hospitalnamecontroller.text,
                                          "designation":
                                              designattioncontroller.text,
                                          "department":
                                              departmentcontroller.text,
                                          "start_date": startcontroller.text,
                                          "end_date": endcontroller.text
                                        });
                                      }
                                    },
                                    child: Get.find<dprofilecontroller>()
                                            .is_experiance_add
                                            .value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              ButtonSpinner(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Saving..."),
                                            ],
                                          )
                                        : const Text("Save"),
                                  ),
                                )),
                          );
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
