import 'package:get/get.dart';

class dappointmentcontroller extends GetxController {
  var intial_menu_item = 0.obs;
  var is_updating_appoi_status = false.obs;
  var is_updating_appoi_status_confirm = false.obs;
  var notification_type = "".obs;

  var is_sending_message = false.obs;
  var is_emoje_show = false.obs;
  var is_complating = false.obs;

  //
  var has_upcomi = false.obs;
  var has_new = false.obs;
  var has_compla = false.obs;
}
