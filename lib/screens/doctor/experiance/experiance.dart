import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../apiservice/subscriptions.dart';
import '../../../controllers/doctor_controllers/dprofilecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';
import '../../../widgets/cool_loading.dart';

class Experiance extends StatefulWidget {
  Experiance({super.key});

  @override
  State<Experiance> createState() => _ExperianceState();
}

class _ExperianceState extends State<Experiance> {
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
          "Experiance",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/daddexp");
        },
        child: const FaIcon(FontAwesomeIcons.add),
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Subscription(
            options: SubscriptionOptions(
              document: gql(MySubscription.experiance),
              variables: {"id": id},
            ),
            builder: (result) {
              if (result.isLoading) {
                return Center(child: cool_loding());
              }

              List experiance = result.data!["experiences"];
              if (experiance.isEmpty) {
                return SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.suitcase,
                        color: Constants.primcolor,
                      ),
                      Text("No experiance found!"),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                );
              }
              return ResultAccumulator.appendUniqueEntries(
                latest: result.data,
                builder: (p0, {results}) {
                  return ListView.builder(
                    itemCount: experiance.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: Get.width,
                            height: 200,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Constants.primcolor.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hospital ",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  experiance[index]["hospital_name"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Designation",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  experiance[index]["designation"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "Department",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  experiance[index]["department"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "Employment Period",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  "${experiance[index]["start_date"]} to ${experiance[index]["end_date"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Mutation(
                            options: MutationOptions(
                              document: gql(Mymutation.delete_experiance),
                              onError: (error) {
                                Get.find<dprofilecontroller>()
                                    .is_experiance_deleted
                                    .value = false;
                                Get.find<dprofilecontroller>()
                                    .customsnack(error.toString());
                              },
                              onCompleted: (data) {
                                Get.find<dprofilecontroller>()
                                    .is_experiance_deleted
                                    .value = false;
                                experiance.removeAt(index);
                                setState(() {});
                              },
                            ),
                            builder: (runMutation, result) {
                              if (result!.isLoading) {
                                Get.find<dprofilecontroller>()
                                    .is_experiance_deleted
                                    .value = true;
                              }
                              return Positioned(
                                top: 0,
                                right: 0,
                                child: Obx(() => GestureDetector(
                                      onTap: () {
                                        runMutation(
                                            {"id": experiance[index]["id"]});
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 50,
                                        margin: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: Constants.primcolor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(50))),
                                        child: Center(
                                          child: Get.find<dprofilecontroller>()
                                                  .is_experiance_deleted
                                                  .value
                                              ? const ButtonSpinner()
                                              : const FaIcon(
                                                  FontAwesomeIcons.deleteLeft,
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
          )),
    );
  }
}
