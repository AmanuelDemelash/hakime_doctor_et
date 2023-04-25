import 'package:country_phone_code_picker/controller/country_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../doctor/dsignup.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final _formkey = GlobalKey<FormState>();
  CountryController countryController = CountryController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _datebirthcontroller = TextEditingController();

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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 200,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              height: 240,
              margin: const EdgeInsets.only(top: 40),
              child: Column(
                children: const [
                  SizedBox(
                    height: 15,
                  ),
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 110,
                    height: 110,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Create new  account",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            backgroundColor: Constants.whitesmoke,
            elevation: 0,
          ),
          body: Dsignup(),
        ));
  }
}
