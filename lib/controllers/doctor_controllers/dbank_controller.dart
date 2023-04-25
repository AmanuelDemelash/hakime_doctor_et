import 'package:get/get.dart';

class DbankController extends GetxController {
  var is_deleting_bankinfo = false.obs;
  var is_bank_added = false.obs;

  // withdrawals

  var bank_to_withdraw = 0.obs;
  var is_withdraw = false.obs;
}
