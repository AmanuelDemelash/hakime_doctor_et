import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../apiservice/myquery.dart';
import '../../utils/constants.dart';
import '../splashcontroller.dart';

class dhomepagecontroller extends GetxController {
  var current_bnb_item = 0.obs;
  RxBool isonline = false.obs;

  Future<void> get_more_options() async {
    Get.bottomSheet(ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            color: Constants.whitesmoke,
            height: Get.height / 1.5,
            width: Get.width,
            child: Column(
              children: [
                Row(
                  children: const [
                    Spacer(),
                    Expanded(
                        child: Divider(
                      thickness: 3,
                      color: Constants.primcolor,
                    )),
                    Spacer()
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    //profile
                    GestureDetector(
                      onTap: () => Get.toNamed("/dprofile"),
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Image(
                                image: AssetImage("assets/images/user.png"),
                                width: 45,
                                height: 45,
                              ),
                              Flexible(
                                child: Text("profile".tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                    //myblogs
                    GestureDetector(
                      onTap: () => Get.toNamed("/dblog"),
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Image(
                                image: AssetImage("assets/images/blog.png"),
                                width: 45,
                                height: 45,
                              ),
                              Flexible(
                                child: Text("my_blog".tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                    //bank info
                    GestureDetector(
                      onTap: () => Get.toNamed("/dbank"),
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Image(
                                image: AssetImage("assets/images/bank.png"),
                                width: 40,
                                height: 40,
                              ),
                              Flexible(
                                child: Text(
                                  "bank_info".tr,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                    ),
                    //wllet
                    GestureDetector(
                      onTap: () => Get.toNamed("/dwallet"),
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: const [
                              Image(
                                image: AssetImage("assets/images/wallet.png"),
                                width: 45,
                                height: 45,
                              ),
                              Flexible(
                                child: Text("wallet",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                    //withdrawal
                    Container(
                        width: 90,
                        height: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: const [
                            Image(
                              image: AssetImage("assets/images/withdraw.png"),
                              width: 45,
                              height: 45,
                            ),
                            Text("withdraw",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        )),
                    // notification
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/dnotification");
                      },
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Query(
                                options: QueryOptions(
                                    document: gql(Myquery.doc_notification),
                                    variables: {
                                      "id": Get.find<SplashController>()
                                          .prefs
                                          .getInt("id")
                                    }),
                                builder: (result, {fetchMore, refetch}) {
                                  if (result.hasException) {
                                    return const Image(
                                      image: AssetImage(
                                          "assets/images/notification.png"),
                                      width: 35,
                                      height: 35,
                                    );
                                  }
                                  if (result.isLoading) {
                                    return const Image(
                                      image: AssetImage(
                                          "assets/images/notification.png"),
                                      width: 35,
                                      height: 35,
                                    );
                                  }
                                  List? notifi = result.data!["notifications"];
                                  return Badge(
                                    showBadge: notifi!.isEmpty ? false : true,
                                    badgeColor: Colors.red,
                                    shape: BadgeShape.circle,
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    position:
                                        BadgePosition.topEnd(top: -10, end: 1),
                                    badgeContent: Text(
                                      notifi.length.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/images/notification.png"),
                                      width: 35,
                                      height: 35,
                                    ),
                                  );
                                },
                              ),
                              const Flexible(
                                child: Text("Notifications",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                    // help center
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Image(
                                image:
                                    AssetImage("assets/images/helpcenter.png"),
                                width: 45,
                                height: 45,
                              ),
                              Flexible(
                                child: Text("help_center".tr,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),

                    // setting
                    GestureDetector(
                      onTap: () => Get.toNamed("/setting"),
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: const [
                              Image(
                                image: AssetImage("assets/images/setting.png"),
                                width: 45,
                                height: 45,
                              ),
                              Flexible(
                                child: Text("setting",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),

                    //logout
                    GestureDetector(
                      onTap: () async {
                        await Get.find<SplashController>().prefs.remove('id');
                        await Get.find<SplashController>()
                            .prefs
                            .remove('token');
                        await Get.find<SplashController>()
                            .prefs
                            .remove('isdoctor');
                        Get.offAllNamed("/login");
                      },
                      child: Container(
                          width: 90,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: const [
                              Image(
                                image: AssetImage("assets/images/shutdown.png"),
                                width: 45,
                                height: 45,
                              ),
                              Flexible(
                                child: Text("Logout",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
