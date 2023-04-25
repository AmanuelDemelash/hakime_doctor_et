import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../apiservice/subscriptions.dart';
import '../../../controllers/doctor_controllers/dbank_controller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';
import '../../../widgets/cool_loading.dart';

class Dbankinfo extends StatefulWidget {
  Dbankinfo({Key? key}) : super(key: key);

  @override
  State<Dbankinfo> createState() => _DbankinfoState();
}

class _DbankinfoState extends State<Dbankinfo> {
  int id = Get.find<SplashController>().prefs.getInt("id");

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
          "My Bank information",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/addbankinfo"),
        child: const FaIcon(FontAwesomeIcons.add),
      ),
      body: Subscription(
        options: SubscriptionOptions(
          document: gql(MySubscription.bankinfo),
          variables: {"id": id},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(child: cool_loding());
          }

          List bankinfo = result.data!["bank_informations"];
          if (bankinfo.isEmpty) {
            return Center(
              child: Container(
                height: Get.height / 1.5,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage("assets/images/bank.png"),
                      width: 130,
                      height: 130,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No bank information. please add your bank information inorder to request withdrwal from your wallet",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ResultAccumulator.appendUniqueEntries(
            latest: result.data,
            builder: (p0, {results}) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.builder(
                  itemCount: bankinfo.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                        duration: const Duration(seconds: 200),
                        position: id,
                        child: SlideAnimation(
                          child: Stack(
                            children: [
                              Container(
                                width: Get.width,
                                height: 140,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.only(
                                    left: 10, right: 30, top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.bank,
                                          color: Colors.black38,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "Bank Name :",
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: Text(
                                                bankinfo[index]["bank_name"]))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const FaIcon(FontAwesomeIcons.person,
                                            color: Colors.black38),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "Holder Name :",
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(bankinfo[index]["full_name"]),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const FaIcon(
                                            FontAwesomeIcons.addressCard,
                                            color: Colors.black38),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "Account No :",
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(bankinfo[index]["account_number"])
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    decoration: BoxDecoration(
                                        color: Constants.primcolor
                                            .withOpacity(0.7),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            topRight: Radius.circular(10))),
                                    child: Mutation(
                                      options: MutationOptions(
                                        document:
                                            gql(Mymutation.delete_bank_info),
                                        onCompleted: (data) {
                                          Get.find<DbankController>()
                                              .is_deleting_bankinfo
                                              .value = false;
                                          bankinfo.removeAt(index);
                                          setState(() {});
                                        },
                                      ),
                                      builder: (runMutation, result) {
                                        if (result!.isLoading) {
                                          Get.find<DbankController>()
                                              .is_deleting_bankinfo
                                              .value = true;
                                        }
                                        return IconButton(
                                            onPressed: () {
                                              // run mutation
                                              runMutation({
                                                "id": bankinfo[index]["id"]
                                              });
                                            },
                                            icon: Get.find<DbankController>()
                                                    .is_deleting_bankinfo
                                                    .value
                                                ? const ButtonSpinner()
                                                : const FaIcon(
                                                    FontAwesomeIcons.remove,
                                                    color: Colors.white,
                                                  ));
                                      },
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
