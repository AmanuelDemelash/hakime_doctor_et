import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../apiservice/myquery.dart';
import '../../../controllers/doctor_controllers/dprofilecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';

class Dwallet extends StatelessWidget {
  Dwallet({Key? key}) : super(key: key);

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
          "My Wallet",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Query(
                options: QueryOptions(
                  document: gql(Myquery.doc_wallet),
                  variables: {"id": id},
                  pollInterval: const Duration(seconds: 10),
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                      child: Container(
                        width: Get.width,
                        height: 250,
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    );
                  }
                  int wallet = result.data!["doctors_by_pk"]["wallet"];
                  List? banks =
                      result.data!["doctors_by_pk"]["bank_informations"];

                  return Row(
                    children: [
                      Container(
                        width: 15,
                        height: 190,
                        decoration: const BoxDecoration(
                            color: Constants.primcolor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ),
                      Expanded(
                        child: Container(
                          width: Get.width,
                          height: 250,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(colors: [
                              Constants.primcolor,
                              Constants.primcolor.withOpacity(0.5)
                            ]),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Avalable balance",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "ETB $wallet",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(15),
                                        backgroundColor: Constants.primcolor
                                            .withOpacity(0.4),
                                        elevation: 0),
                                    onPressed: () {
                                      if (wallet < 500) {
                                        Get.find<dprofilecontroller>().customsnack(
                                            "The minmum withdrawal amount is 500 Birr");
                                      } else if (banks!.isEmpty) {
                                        Get.find<dprofilecontroller>().customsnack(
                                            "Please add your bank information");
                                      } else {
                                        Get.toNamed("/dwithdraw",
                                            arguments: wallet);
                                      }
                                    },
                                    child:
                                        const Text("Send withdrawal request")),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 15,
                        height: 190,
                        decoration: const BoxDecoration(
                            color: Constants.primcolor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("My withdrawals"),
                    Row(
                      children: const [
                        Text("See all"),
                        SizedBox(
                          width: 10,
                        ),
                        FaIcon(
                          FontAwesomeIcons.angleRight,
                          size: 12,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // withdrawals
              Query(
                options: QueryOptions(
                  document: gql(Myquery.doc_withdrawls),
                  variables: {"id": id},
                  pollInterval: const Duration(seconds: 5),
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Shimmer.fromColors(
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.white,
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: Shimmer.fromColors(
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.white,
                            child: Container(
                              width: 1500,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  List? withdraw = result.data!["withdrawals"];
                  if (withdraw!.isEmpty) {
                    return const Center(
                      child: Text("No withdrawals "),
                    );
                  }
                  return ListView.separated(
                    itemCount: withdraw.length,
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const Divider(
                        color: Colors.black12,
                        thickness: 2,
                      ),
                    ),
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ListTile(
                        title: Text(
                          "ETB ${withdraw[index]["amount"]}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(withdraw[index]["created_at"]),
                        trailing: Text(
                          withdraw[index]["status"],
                          style: TextStyle(
                              color: withdraw[index]["status"] == "pending"
                                  ? Colors.red
                                  : Constants.primcolor.withOpacity(0.7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
