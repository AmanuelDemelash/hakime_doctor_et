import 'package:country_phone_code_picker/controller/country_controller.dart';
import 'package:country_phone_code_picker/core/country_phone_code_picker_widget.dart';
import 'package:country_phone_code_picker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_doctor_et/controllers/doctor_controllers/dsignupcontroller.dart';

import '../../apiservice/mymutation.dart';
import '../../apiservice/myquery.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/splashcontroller.dart';
import '../../utils/constants.dart';
import '../../widgets/buttonspinner.dart';

class Dsignup extends StatelessWidget {
  Dsignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.whitesmoke,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: SizedBox(
                width: Get.width,
                height: Get.height,
                child: PageView(
                  controller: Get.find<dsignupcontroller>().pagcontroller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [form1(), form2(), form3()],
                )),
          ),
        ));
  }
}

class form3 extends StatelessWidget {
  form3({
    Key? key,
  }) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _experiancecontroller = TextEditingController();

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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                // experiance
                const Text("Experiyance year"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _experiancecontroller,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return customsnack("enter your experiance year");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "0+",
                      filled: true,
                      contentPadding: const EdgeInsets.all(17),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.whitesmoke),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.primcolor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.primcolor.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white),
                ),
                // consoltancy fee
                const SizedBox(
                  height: 20,
                ),
                const Text("User Name*"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _usernamecontroller,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return customsnack("enter your username");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "@username",
                      filled: true,
                      contentPadding: const EdgeInsets.all(17),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.whitesmoke),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.primcolor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.primcolor.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx(() => CheckboxListTile(
                      activeColor: Constants.primcolor,
                      title: const Text(
                        "By signed up you will accept our privecy policy",
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                      value: Get.find<dsignupcontroller>().accept_policy.value,
                      onChanged: (value) {
                        Get.find<dsignupcontroller>().accept_policy.value =
                            value!;
                      },
                    )),
                const SizedBox(
                  height: 30,
                ),
                Mutation(
                  options: MutationOptions(
                    document: gql(Mymutation.doctorsignup),
                    onError: (error) {
                      customsnack(error.toString());
                      Get.find<dsignupcontroller>().is_signup.value = false;
                    },
                    onCompleted: (data) {
                      if (data!.isNotEmpty) {
                        Get.find<SplashController>()
                            .prefs
                            .setInt('id', data["doctorSignUp"]["id"]);
                        Get.find<SplashController>()
                            .prefs
                            .setString('token', data["doctorSignUp"]["token"]);
                        Get.find<SplashController>()
                            .prefs
                            .setBool('isdoctor', true);
                        Get.find<SplashController>()
                            .prefs
                            .setBool('isverifay', false);
                        Get.find<dsignupcontroller>().is_signup.value = false;
                        Get.find<NotificationController>().crateNotification(
                            "OTP",
                            "Your confirmation number is ${data["doctorSignUp"]["code"]} ");

                        Get.offAllNamed("/verification");
                      }
                      Get.find<dsignupcontroller>().is_signup.value = false;
                    },
                  ),
                  builder: (runMutation, result) {
                    if (result!.hasException) {
                      print(result.exception.toString());
                    }
                    if (result.isLoading) {
                      Get.find<dsignupcontroller>().is_signup.value = true;
                    }

                    return SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          Constants.primcolor.withOpacity(0.3),
                                      padding: const EdgeInsets.all(15)),
                                  onPressed: () {
                                    Get.find<dsignupcontroller>()
                                        .pagcontroller
                                        .jumpToPage(1);
                                  },
                                  child: const Text(
                                    "previous",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Obx(
                              () => ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: const EdgeInsets.all(15)),
                                    onPressed: () {
                                      _formkey.currentState!.save();
                                      if (_formkey.currentState!.validate()) {
                                        if (Get.find<dsignupcontroller>()
                                                .accept_policy
                                                .value ==
                                            false) {
                                          customsnack(
                                              "plase accept privacy policy");
                                        } else {
                                          Get.find<dsignupcontroller>()
                                                  .experiance_year
                                                  .value =
                                              int.parse(_experiancecontroller
                                                  .text
                                                  .toString());
                                          Get.find<dsignupcontroller>()
                                                  .user_name
                                                  .value =
                                              "@${_usernamecontroller.text}";

                                          // run mutation to signup doc
                                          runMutation({
                                            "full_name":
                                                Get.find<dsignupcontroller>()
                                                    .full_name
                                                    .value,
                                            "user_name":
                                                Get.find<dsignupcontroller>()
                                                    .user_name
                                                    .value,
                                            "date_of_birth":
                                                Get.find<dsignupcontroller>()
                                                    .dateofbirth
                                                    .value,
                                            "experience_year":
                                                Get.find<dsignupcontroller>()
                                                    .experiance_year
                                                    .value,
                                            "licence":
                                                Get.find<dsignupcontroller>()
                                                    .cv
                                                    .value,
                                            "speciallity":
                                                Get.find<dsignupcontroller>()
                                                    .specility
                                                    .value,
                                            "phone_number":
                                                Get.find<dsignupcontroller>()
                                                    .phone
                                                    .value,
                                            "profile_picture":
                                                Get.find<dsignupcontroller>()
                                                    .profile_pic
                                                    .value,
                                            "current_hospital":
                                                Get.find<dsignupcontroller>()
                                                    .hospital
                                                    .value,
                                            "email":
                                                Get.find<dsignupcontroller>()
                                                    .email
                                                    .value,
                                            "password":
                                                Get.find<dsignupcontroller>()
                                                    .password
                                                    .value,
                                            "sex": Get.find<dsignupcontroller>()
                                                .sex
                                                .value
                                          });
                                        }
                                      }
                                    },
                                    child: Get.find<dsignupcontroller>()
                                            .is_signup
                                            .value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              ButtonSpinner(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Signing up...")
                                            ],
                                          )
                                        : const Text("Sign Up")),
                              ),
                            )),
                          ],
                        ));
                  },
                )
              ],
            )),
      ),
    );
  }
}

class form2 extends StatelessWidget {
  form2({
    Key? key,
  }) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  CountryController countryController = CountryController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();

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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // cv
                const SizedBox(height: 10),
                const Text("Your Licence*"),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<dsignupcontroller>().getdoctor_license(),
                  child: Obx(() => Container(
                        width: Get.width,
                        height: 55,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child:
                            Get.find<dsignupcontroller>().cv_file_name.value ==
                                    ""
                                ? Row(
                                    children: const [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FaIcon(FontAwesomeIcons.filePdf),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("attach your licence")
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const FaIcon(FontAwesomeIcons.filePdf),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(Get.find<dsignupcontroller>()
                                          .cv_file_name
                                          .value
                                          .toString()),
                                    ],
                                  ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                //phone number
                const Text("Phone number"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CountryPhoneCodePicker.withDefaultSelectedCountry(
                      defaultCountryCode: Country(
                          name: 'Ethiopia',
                          countryCode: 'ET',
                          phoneCode: '+251'),
                      showPhoneCode: true,
                      borderRadius: 10,
                      borderWidth: 1,
                      width: 100,
                      borderColor: Constants.primcolor.withOpacity(0.2),
                      style: const TextStyle(fontSize: 13),
                      searchBarHintText: 'Search by name',
                      countryController: countryController,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _phonecontroller,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return customsnack("enter phone number");
                          } else if (!RegExp("^[0-9]").hasMatch(value)) {
                            customsnack("Please enter valid phone number");
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "phone number",
                            filled: true,
                            contentPadding: const EdgeInsets.all(17),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.primcolor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Constants.primcolor.withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            fillColor: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // email
                const Text("Email*"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == "") {
                      customsnack("enter your email");
                    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value!)) {
                      customsnack("Please valid Email");
                    } else {
                      return null;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "email",
                      filled: true,
                      contentPadding: const EdgeInsets.all(17),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.whitesmoke),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.primcolor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.primcolor.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white),
                ),
                //password
                const SizedBox(
                  height: 20,
                ),
                const Text("Password*"),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => TextFormField(
                      controller: _passwordcontroller,
                      keyboardType: TextInputType.text,
                      obscureText:
                          Get.find<dsignupcontroller>().password_visible.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return customsnack("empty password");
                        } else if (value.length < 6) {
                          return customsnack("Password length must be 6");
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "***********",
                          filled: true,
                          suffixIcon: IconButton(
                              onPressed: () {
                                Get.find<dsignupcontroller>()
                                        .password_visible
                                        .value =
                                    !Get.find<dsignupcontroller>()
                                        .password_visible
                                        .value;
                              },
                              icon: Get.find<dsignupcontroller>()
                                          .password_visible
                                          .value ==
                                      true
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black45,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black45,
                                    )),
                          contentPadding: const EdgeInsets.all(17),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.whitesmoke),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primcolor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.primcolor.withOpacity(0.2)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white),
                    )),

                const SizedBox(
                  height: 60,
                ),
                Mutation(
                  options: MutationOptions(
                    document: gql(Mymutation.uploadfile),
                    onError: (error) {
                      customsnack("licence upload error");
                    },
                    onCompleted: (data) {
                      Get.find<dsignupcontroller>().is_cv_uploading.value =
                          false;
                      Get.find<dsignupcontroller>().pagcontroller.jumpToPage(2);
                    },
                  ),
                  builder: (runMutation, result) {
                    if (result!.isLoading) {
                      Get.find<dsignupcontroller>().is_cv_uploading.value =
                          true;
                    }

                    if (result.data != null && result.data!.isNotEmpty) {
                      Get.find<dsignupcontroller>().cv.value =
                          result.data!["uploadImage"]["id"];
                    }
                    return SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Constants.primcolor.withOpacity(0.3),
                                      elevation: 0,
                                      padding: const EdgeInsets.all(15)),
                                  onPressed: () {
                                    Get.find<dsignupcontroller>()
                                        .pagcontroller
                                        .jumpToPage(0);
                                  },
                                  child: const Text(
                                    "Previous",
                                    style: TextStyle(color: Colors.black54),
                                  )),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Obx(() => ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            padding: const EdgeInsets.all(15)),
                                        onPressed: () {
                                          _formkey.currentState!.save();
                                          if (_formkey.currentState!
                                              .validate()) {
                                            if (Get.find<dsignupcontroller>()
                                                    .is_cv
                                                    .value ==
                                                false) {
                                              customsnack(
                                                  "attach your licence");
                                            } else {
                                              Get.find<dsignupcontroller>()
                                                      .phone
                                                      .value =
                                                  _phonecontroller.text;
                                              Get.find<dsignupcontroller>()
                                                      .email
                                                      .value =
                                                  _emailcontroller.text;
                                              Get.find<dsignupcontroller>()
                                                      .password
                                                      .value =
                                                  _passwordcontroller.text;
                                              runMutation({
                                                "base64": Get.find<
                                                        dsignupcontroller>()
                                                    .cv_base64
                                                    .value
                                                    .toString()
                                              });
                                            }
                                          }
                                        },
                                        child: Get.find<dsignupcontroller>()
                                                .is_cv_uploading
                                                .value
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  ButtonSpinner(),
                                                  Text("Waiting...")
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    "Next",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  FaIcon(
                                                    FontAwesomeIcons.arrowRight,
                                                    size: 17,
                                                  )
                                                ],
                                              )),
                                  )),
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class form1 extends StatelessWidget {
  form1({
    Key? key,
  }) : super(key: key);

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

  final _formkey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _dateofbirthcontroller = TextEditingController();
  TextEditingController _specilitycontroller = TextEditingController();
  TextEditingController _hospitalcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  name
              const Text("Full Name*"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _namecontroller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return customsnack("enter your name");
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "full name",
                    filled: true,
                    contentPadding: const EdgeInsets.all(17),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              //gender
              ListTile(
                title: const Text("Gender *"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Radio(
                            value: "male",
                            groupValue: Get.find<dsignupcontroller>().sex.value,
                            onChanged: (value) {
                              Get.find<dsignupcontroller>().sex.value = value!;
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                        const Text("Male"),
                        const SizedBox(
                          width: 20,
                        ),
                        Obx(() => Radio(
                              value: "female",
                              groupValue:
                                  Get.find<dsignupcontroller>().sex.value,
                              onChanged: (value) {
                                Get.find<dsignupcontroller>().sex.value =
                                    value!;
                              },
                              activeColor: Colors.green,
                            )),
                        const Text("Female")
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // date of birth
              const Text("Date of Birth*"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _dateofbirthcontroller,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return customsnack("enter your date of birth");
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Date of birth",
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1978),
                              lastDate: DateTime(2070));
                          _dateofbirthcontroller.text =
                              "${date?.day}-${date?.month}-${date?.year}";
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 18,
                        )),
                    contentPadding: const EdgeInsets.all(17),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              // speciality
              const Text("Speciality *"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _specilitycontroller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return customsnack("enter your speciality");
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Speciality",
                    filled: true,
                    suffixIcon: Query(
                      options:
                          QueryOptions(document: gql(Myquery.allspeciality)),
                      builder: (result, {fetchMore, refetch}) {
                        if (result.isLoading) {
                          return const CircularProgressIndicator(
                            color: Constants.primcolor,
                          );
                        }
                        List speciality = result.data!['speciallities'];

                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: PopupMenuButton<String>(
                              child: const FaIcon(
                                FontAwesomeIcons.angleDown,
                                color: Colors.black45,
                              ),
                              onSelected: (value) {
                                Get.find<dsignupcontroller>().specility.value =
                                    int.parse(value);
                                _specilitycontroller.text =
                                    speciality[int.parse(value) - 1]
                                            ["speciallity_name"]
                                        .toString();
                              },
                              itemBuilder: (context) => List.generate(
                                    speciality.length,
                                    (index) => PopupMenuItem(
                                        value:
                                            speciality[index]["id"].toString(),
                                        child: Text(speciality[index]
                                                ['speciallity_name']
                                            .toString())),
                                  )),
                        );
                      },
                    ),
                    contentPadding: const EdgeInsets.all(17),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.7)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white),
              ),

              const SizedBox(
                height: 15,
              ),
              const Text("Hospital*"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _hospitalcontroller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return customsnack("enter your hospitl");
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "hospital you work on",
                    filled: true,
                    contentPadding: const EdgeInsets.all(17),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.7)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.primcolor.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white),
              ),

              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Profile image *"),
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Obx(() => CircleAvatar(
                        radius: 60,
                        backgroundImage: Get.find<dsignupcontroller>()
                                .is_image
                                .value
                            ? FileImage(
                                    Get.find<dsignupcontroller>().image.value)
                                as ImageProvider
                            : const AssetImage("assets/images/user.png"))),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Constants.primcolor,
                                shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    Get.find<dsignupcontroller>()
                                        .getprofile_image();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.images,
                                    size: 15,
                                    color: Colors.white,
                                  )),
                            )))
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              //next button
              Mutation(
                options: MutationOptions(
                  document: gql(Mymutation.uploadfile),
                  onError: (error) {},
                  onCompleted: (data) {
                    Get.find<dsignupcontroller>().is_image_uploading.value =
                        false;
                    Get.find<dsignupcontroller>().pagcontroller.jumpToPage(1);
                  },
                ),
                builder: (runMutation, result) {
                  if (result!.isLoading) {
                    Get.find<dsignupcontroller>().is_image_uploading.value =
                        true;
                  }

                  if (result.data != null && result.data!.isNotEmpty) {
                    Get.find<dsignupcontroller>().profile_pic.value =
                        result.data!["uploadImage"]["id"];
                  }
                  return SizedBox(
                      width: Get.width,
                      child: Obx(() => ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(15)),
                                onPressed: () async {
                                  _formkey.currentState!.save();
                                  if (_formkey.currentState!.validate()) {
                                    // run mutation to upoald image and get url then on complate update all data
                                    if (Get.find<dsignupcontroller>()
                                        .sex
                                        .value
                                        .isEmpty) {
                                      customsnack("enter your gender");
                                    } else if (Get.find<dsignupcontroller>()
                                        .is_image
                                        .value) {
                                      Get.find<dsignupcontroller>()
                                          .full_name
                                          .value = _namecontroller.text;
                                      Get.find<dsignupcontroller>()
                                          .dateofbirth
                                          .value = _dateofbirthcontroller.text;

                                      Get.find<dsignupcontroller>()
                                          .hospital
                                          .value = _hospitalcontroller.text;
                                      runMutation({
                                        "base64": Get.find<dsignupcontroller>()
                                            .profile_picture_base64
                                            .toString()
                                      });
                                    } else {
                                      customsnack("upload your profile photo");
                                    }
                                  }
                                },
                                child: Get.find<dsignupcontroller>()
                                        .is_image_uploading
                                        .value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          ButtonSpinner(),
                                          Text("Loading...")
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Next",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.arrowRight,
                                            size: 17,
                                          )
                                        ],
                                      )),
                          )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
