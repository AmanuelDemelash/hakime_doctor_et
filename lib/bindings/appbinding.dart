import 'package:get/get.dart';
import 'package:hakime_doctor_et/controllers/doctor_controllers/writeprescriptioncontroller.dart';

import '../controllers/connectivity.dart';
import '../controllers/doctor_controllers/blog_controller.dart';
import '../controllers/doctor_controllers/dappointmentcontroller.dart';
import '../controllers/doctor_controllers/dbank_controller.dart';
import '../controllers/doctor_controllers/dhomepagecontroller.dart';
import '../controllers/doctor_controllers/dpackagecontroller.dart';
import '../controllers/doctor_controllers/dprofilecontroller.dart';
import '../controllers/doctor_controllers/dsignupcontroller.dart';
import '../controllers/doctor_controllers/logincontroller.dart';
import '../controllers/locationcontrollers.dart';
import '../controllers/notification_controller.dart';
import '../controllers/splashcontroller.dart';
import '../controllers/translationcontroller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(LoginController());
    Get.put(CheekConnecctivityController());
    Get.put(dsignupcontroller());
    Get.put(dhomepagecontroller());
    Get.put(dappointmentcontroller());
    Get.put(dprofilecontroller());
    Get.put(Locationcontrollers());
    Get.put(TransalationControlers());
    Get.put(DbankController());
    Get.put(DpackageController());
    Get.put(BlogController());
    Get.put(NotificationController());
    Get.put(WritrprescriptionController());
  }
}
