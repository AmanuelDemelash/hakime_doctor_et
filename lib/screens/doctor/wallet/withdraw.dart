import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/doctor_controllers/dbank_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';
import '../../../widgets/loading.dart';

class DWithdraw extends StatelessWidget {
  DWithdraw({super.key});

  TextEditingController _amountcontroller = TextEditingController();
  var wallet = Get.arguments;
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
          "Withdraw",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text("Choose Bank"),
              // banks
              Query(
                options: QueryOptions(
                  document: gql(Myquery.bankinfo),
                  variables: {
                    "id": Get.find<SplashController>().prefs.getInt("id")
                  },
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    print(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return loading();
                  }
                  List? banks = result.data!["bank_informations"];
                  if (banks!.isEmpty) {
                    return Text("no bank account");
                  }

                  return Wrap(
                    children: List.generate(
                        banks.length,
                        (index) => ListTile(
                              leading: Obx(() => Radio(
                                    value: banks[index]["id"],
                                    groupValue: Get.find<DbankController>()
                                        .bank_to_withdraw
                                        .value,
                                    onChanged: (value) {
                                      Get.find<DbankController>()
                                          .bank_to_withdraw
                                          .value = value!;
                                    },
                                    activeColor: Colors.green,
                                  )),
                              title: Text(banks[index]["bank_name"]),
                              subtitle: Text(banks[index]["account_number"]),
                            )),
                  );
                },
              ),
              const Text("Enter Amount"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    customsnack("enter amount you want to withdraw");
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    hintText: "Amount",
                    enabled: true,
                    filled: true,
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.whitesmoke),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    fillColor: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              Mutation(
                options: MutationOptions(
                  document: gql(Mymutation.update_wallet_withdraw),
                  onCompleted: (data) {
                    Get.find<DbankController>().is_withdraw.value = false;
                    Get.find<NotificationController>().crateNotification(
                        "Withdraw",
                        "your withdrawal is being processing. it takes 24H to make transaction please   ");
                    Get.back();
                  },
                ),
                builder: (runMutation, result) {
                  return Mutation(
                    options: MutationOptions(
                      document: gql(Mymutation.withdraw_request),
                      onCompleted: (data) {
                        if (data!.isNotEmpty) {
                          runMutation({
                            "id":
                                Get.find<SplashController>().prefs.getInt("id"),
                            "wallet": wallet -
                                int.parse(_amountcontroller.text.toString())
                          });
                        }
                      },
                    ),
                    builder: (runMutation, result) {
                      if (result!.hasException) {
                        print(result.exception.toString());
                      }
                      if (result.isLoading) {
                        Get.find<DbankController>().is_withdraw.value = true;
                      }
                      return SizedBox(
                          width: Get.width,
                          child: Obx(() => ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(17)),
                                onPressed: () {
                                  if (Get.find<DbankController>()
                                          .bank_to_withdraw
                                          .value ==
                                      0) {
                                    customsnack("choose bank to withdraw");
                                  } else if (_amountcontroller.text.isEmpty) {
                                    customsnack(
                                        "enter amount you want to withdraw");
                                  } else if (int.parse(_amountcontroller.text
                                              .toString()) >
                                          wallet ||
                                      int.parse(_amountcontroller.text
                                              .toString()) <
                                          500) {
                                    customsnack(
                                        "the minmum amount to withdraw is ETB 500");
                                  } else {
                                    runMutation({
                                      "doctor_id": Get.find<SplashController>()
                                          .prefs
                                          .getInt("id"),
                                      "amount": int.parse(
                                          _amountcontroller.text.toString())
                                    });
                                  }
                                },
                                child: Get.find<DbankController>()
                                        .is_withdraw
                                        .value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          ButtonSpinner(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("please wait...")
                                        ],
                                      )
                                    : const Text("withdraw"),
                              ))));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
