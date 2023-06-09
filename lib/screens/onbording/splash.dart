import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splashcontroller.dart';
import '../../utils/constants.dart';
import '../../widgets/cool_loading.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Get.find<SplashController>().user_statuss_data();
    Get.find<SplashController>().gotonext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 130,
                    height: 130,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    Constants.app_name,
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, letterSpacing: 1),
                  ),
                ],
              ),
            )),
            const cool_loding(),
            Container(
              height: 150,
            ),
            const Text(
              "From",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            const Text(
              "CodeValley",
              style: TextStyle(
                  color: Constants.primcolor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
