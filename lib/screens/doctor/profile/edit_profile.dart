import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/doctor_controllers/dprofilecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';
import '../../../widgets/cool_loading.dart';

class Edit_profile extends StatefulWidget {
  Edit_profile({super.key});

  @override
  State<Edit_profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  final _formkey = GlobalKey<FormState>();
  int id = Get.find<SplashController>().prefs.getInt("id");

  TextEditingController namecontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController hospitalcontroller = TextEditingController();
  TextEditingController experiancecontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController specialitycontroller = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();

  late List speciality;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    speciality = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.whitesmoke,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Colors.black,
              )),
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            physics: const BouncingScrollPhysics(),
            child: Query(
              options: QueryOptions(
                document: gql(Myquery.doc_info),
                variables: {"id": id},
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return SizedBox(
                    height: Get.height,
                    child: const Center(
                      child: cool_loding(),
                    ),
                  );
                }
                var doc = result.data!["doctors_by_pk"];
                namecontroller.text = doc["full_name"];
                usernamecontroller.text = doc["user_name"];
                phonecontroller.text = doc["phone_number"];
                hospitalcontroller.text = doc["current_hospital"];
                experiancecontroller.text = doc["experience_year"].toString();
                gendercontroller.text = doc["sex"];

                if (speciality.isNotEmpty) {
                  specialitycontroller.text =
                      speciality[doc["speciallity"]]["speciallity_name"];
                  Get.find<dprofilecontroller>().speciality_id.value =
                      doc["speciallity"];
                }
                dateofbirthcontroller.text = doc["date_of_birth"];
                if (doc["bio"] != null) {
                  biocontroller.text = doc["bio"];
                }
                return Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // full name
                      TextFormField(
                        controller: namecontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Full Name",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "first name",
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
                        height: 20,
                      ),
                      //user name
                      TextFormField(
                        controller: usernamecontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "User name",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "@user name",
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
                        height: 20,
                      ),
                      //phone
                      TextFormField(
                        controller: phonecontroller,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Phone numnber",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "+2519********",
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
                        height: 20,
                      ),
                      //hospital
                      TextFormField(
                        controller: hospitalcontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Current Hospital",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "Current Hospital",
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
                        height: 20,
                      ),
                      // expe-year
                      TextFormField(
                        controller: experiancecontroller,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Experiance year",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "0+",
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
                      //sex
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: gendercontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Gender",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "sex",
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
                      //speciality
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: specialitycontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text(
                              "Speciality",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "specialization",
                            suffixIcon: Query(
                              options: QueryOptions(
                                  document: gql(Myquery.allspeciality)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return const CircularProgressIndicator(
                                    color: Constants.primcolor,
                                  );
                                }
                                speciality = result.data!['speciallities'];
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: PopupMenuButton<int>(
                                      child: const FaIcon(
                                        FontAwesomeIcons.angleDown,
                                        color: Colors.black45,
                                      ),
                                      onSelected: (value) {
                                        Get.find<dprofilecontroller>()
                                            .speciality_id
                                            .value = value;
                                        specialitycontroller.text =
                                            speciality[value - 1]
                                                ["speciallity_name"];
                                        setState(() {});
                                      },
                                      itemBuilder: (context) => List.generate(
                                            speciality.length,
                                            (index) => PopupMenuItem(
                                                value: speciality[index]["id"],
                                                child: Text(speciality[index]
                                                        ['speciallity_name']
                                                    .toString())),
                                          )),
                                );
                              },
                            ),
                            filled: true,
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            fillColor: Colors.white),
                      ),
                      //date birth
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: dateofbirthcontroller,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            label: const Text(
                              "Date of birth",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "0+",
                            filled: true,
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1978),
                                      lastDate: DateTime(2070));
                                  dateofbirthcontroller.text =
                                      "${date?.day}-${date?.month}-${date?.year}";
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.calendar,
                                  size: 18,
                                )),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            fillColor: Colors.white),
                      ),
                      // bio
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: biocontroller,
                        keyboardType: TextInputType.text,
                        maxLength: 400,
                        maxLines: 10,
                        validator: (value) {
                          if (value!.isEmpty) {
                            customsnack("add your Bio");
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text(
                              "Bio",
                              style: TextStyle(color: Colors.black45),
                            ),
                            hintText: "bio",
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
                        height: 50,
                      ),
                      // update button
                      Mutation(
                        options: MutationOptions(
                          document: gql(Mymutation.update_doc_pro),
                          onError: (error) {
                            Get.find<dprofilecontroller>()
                                .is_edit_profile
                                .value = false;
                            customsnack(error.toString());
                          },
                          onCompleted: (data) {
                            Get.find<dprofilecontroller>()
                                .is_edit_profile
                                .value = false;
                            Get.back();
                          },
                        ),
                        builder: (runMutation, result) {
                          if (result!.isLoading) {
                            Get.find<dprofilecontroller>()
                                .is_edit_profile
                                .value = true;
                          }
                          return Obx(() => Container(
                              width: Get.width,
                              margin: const EdgeInsets.all(15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    onPressed: () {
                                      _formkey.currentState!.save();
                                      if (_formkey.currentState!.validate()) {
                                        if (biocontroller.text.isEmpty) {
                                          customsnack("Add your Bio");
                                        } else {
                                          runMutation({
                                            "id": id,
                                            "full_name": namecontroller.text,
                                            "user_name":
                                                usernamecontroller.text,
                                            "phone_number":
                                                phonecontroller.text,
                                            "current_hospital":
                                                hospitalcontroller.text,
                                            "experience_year": int.parse(
                                                experiancecontroller.text),
                                            "sex": gendercontroller.text,
                                            "speciallity":
                                                Get.find<dprofilecontroller>()
                                                    .speciality_id
                                                    .value,
                                            "date_of_birth":
                                                dateofbirthcontroller.text,
                                            "bio": biocontroller.text
                                          });
                                        }
                                      }
                                    },
                                    child: Get.find<dprofilecontroller>()
                                            .is_edit_profile
                                            .value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              ButtonSpinner(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Updating...")
                                            ],
                                          )
                                        : const Text("Update")),
                              )));
                        },
                      )
                    ],
                  ),
                );
              },
            )));
  }
}
