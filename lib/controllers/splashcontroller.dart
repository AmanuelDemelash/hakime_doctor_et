import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connectivity.dart';

class SplashController extends GetxController {
  var currentonbord_screen = 0.obs;
  var islogin = false.obs;
  //var token = null.obs;
  late final prefs;

  Future<void> gotonext() async {
    bool connec =
        Get.find<CheekConnecctivityController>().has_connecction.value;
    Future.delayed(const Duration(seconds: 5), () async {
      var first_time = await prefs.getBool('firsttime');
      var token = await prefs.getString("token");
      var isverifay = await prefs.getBool("isverifay");

      first_time == null
          ? Get.offNamed("/onbording")
          : token == null
              ? Get.offNamed("/login")
              : isverifay == false
                  ? Get.offNamed("/verification")
                  : Get.offNamed("/dhomepage");

      // } else {
      //   Get.snackbar("connection lost", "cheek your connection...",
      //       isDismissible: false,
      //       icon:
      //           const Icon(Icons.signal_wifi_connected_no_internet_4_outlined),
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.red,
      //       colorText: Colors.black);
      // }
    });
  }

  Future<void> user_statuss_data() async {
    prefs = await SharedPreferences.getInstance();
  }
}
