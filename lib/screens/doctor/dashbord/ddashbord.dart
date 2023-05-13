import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/doctor_controllers/dhomepagecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/cool_loading.dart';

class Ddashbord extends StatelessWidget {
  Ddashbord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.whitesmoke,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Constants.whitesmoke,
          leading: Container(
            margin: const EdgeInsets.all(6),
            child: Image.asset(
              "assets/images/logo.png",
              width: 55,
              height: 55,
            ),
          ),
          title: const Text(
            "Hakime",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          actions: [
            Query(
              options: QueryOptions(
                document: gql(Myquery.get_online_doctor),
                variables: {
                  "id": Get.find<SplashController>().prefs.getInt("id")
                },
                onComplete: (data) {
                  if (data.isNotEmpty) {
                    Get.find<dhomepagecontroller>().isonline.value =
                        data["doctors_by_pk"]["is_online"];
                  }
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Obx(() => Switch.adaptive(
                      activeColor: Constants.primcolor,
                      value: Get.find<dhomepagecontroller>().isonline.value,
                      onChanged: (value) async {}));
                }
                if (result.isLoading) {
                  return Obx(() => Switch.adaptive(
                      activeColor: Constants.primcolor,
                      value: Get.find<dhomepagecontroller>().isonline.value,
                      onChanged: (value) async {}));
                }
                // bool isonline = result.data!["doctors_by_pk"]["is_online"];
                // Get.find<dhomepagecontroller>().isonline.value = isonline;

                return Mutation(
                    options: MutationOptions(
                      document: gql(Mymutation.update_online_statuss),
                    ),
                    builder: (runMutation, result) {
                      return Obx(() => Switch.adaptive(
                            activeColor: Constants.primcolor,
                            value:
                                Get.find<dhomepagecontroller>().isonline.value,
                            onChanged: (value) async {
                              runMutation({
                                "id": Get.find<SplashController>()
                                    .prefs
                                    .getInt("id"),
                                "is_online": value
                              });
                              Get.find<dhomepagecontroller>().isonline.value =
                                  value;
                            },
                          ));
                    });
              },
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Obx(() => Center(
                  child: Get.find<dhomepagecontroller>().isonline.value == true
                      ? const Text(
                          "online",
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        )
                      : const Text(
                          "offline",
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ))),
            )
          ],
        ),
        body: Query(
          options: QueryOptions(
            document: gql(Myquery.cheek_approved),
            variables: {"id": Get.find<SplashController>().prefs.getInt("id")},
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return cool_loding();
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // data
                  Container(
                    width: Get.width,
                    height: 300,
                    margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: AnimationLimiter(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: AnimationConfiguration.staggeredList(
                                    duration: const Duration(milliseconds: 300),
                                    position: 0,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: Container(
                                            width: 180,
                                            height: 130,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.green,
                                                  Colors.green.shade200,
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result
                                                              .data![
                                                                  "doctors_by_pk"]
                                                                  [
                                                                  "appointments"]
                                                              .length ==
                                                          0
                                                      ? 0.toString()
                                                      : result
                                                          .data![
                                                              "doctors_by_pk"]
                                                              ["appointments"]
                                                          .length
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text(
                                                  "total_patient".tr,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: AnimationConfiguration.staggeredList(
                                    duration: const Duration(milliseconds: 400),
                                    position: 1,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: Container(
                                            width: 180,
                                            height: 130,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.blue,
                                                  Colors.blue.shade200,
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result
                                                              .data![
                                                                  "doctors_by_pk"]
                                                                  [
                                                                  "appointments"]
                                                              .length ==
                                                          0
                                                      ? 0.toString()
                                                      : result
                                                          .data![
                                                              "doctors_by_pk"]
                                                              ["appointments"]
                                                          .length
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text(
                                                  "total_appo".tr,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: AnimationConfiguration.staggeredList(
                                    duration: const Duration(milliseconds: 500),
                                    position: 2,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: Container(
                                            width: 180,
                                            height: 130,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.teal,
                                                  Colors.green.shade200,
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result.data!["doctors_by_pk"]
                                                          ["wallet"]
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text(
                                                  "total_earning".tr,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: AnimationConfiguration.staggeredList(
                                    duration: const Duration(milliseconds: 500),
                                    position: 3,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: Container(
                                            width: 180,
                                            height: 130,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.purple,
                                                  Colors.purple.shade200,
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result
                                                              .data![
                                                                  "doctors_by_pk"]
                                                                  ["reviews"]
                                                              .length ==
                                                          0
                                                      ? 0.toString()
                                                      : result
                                                          .data![
                                                              "doctors_by_pk"]
                                                              ["reviews"]
                                                          .length
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text(
                                                  "total_review".tr,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                  // appointment data
                  Container(
                    width: Get.width,
                    height: 270,
                    margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Appointments",
                            style: TextStyle(
                              color: Constants.primcolor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //pending
                        Query(
                            options: QueryOptions(
                              document: gql(Myquery.doc_pend_appoi),
                              variables: {
                                "id": Get.find<SplashController>()
                                    .prefs
                                    .getInt("id")
                              },
                            ),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.hasException) {
                                return Container();

                              }
                              if (result.isLoading) {
                                return cool_loding();
                              }
                              List appo=result.data!["appointments"];
                              if (appo.isEmpty) {
                                return SizedBox();
                              }
                              return
                                ListTile(
                                title: const Text("Pending"),
                                leading: const FaIcon(
                                  FontAwesomeIcons.timeline,
                                  color: Colors.amber,
                                ),
                                trailing: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                    child: Text(
                                        appo.isEmpty
                                            ? 0.toString()
                                            :appo.length
                                                .toString())),
                              );
                            }),
                        const Divider(
                          thickness: 1,
                        ),
                        // confirmed
                        Query(
                            options: QueryOptions(
                              document: gql(Myquery.doc_confi_appoi),
                              variables: {
                                "id": Get.find<SplashController>()
                                    .prefs
                                    .getInt("id")
                              },
                            ),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.hasException) {
                                return const SizedBox();
                              }
                              if (result.isLoading) {
                                return const SizedBox();
                              }
                              List appo=result.data!["appointments"];
                              if (appo.isEmpty) {
                                return const SizedBox();
                              }
                              return ListTile(
                                title: const Text("confirmed"),
                                leading: const FaIcon(
                                  FontAwesomeIcons.check,
                                  color: Constants.primcolor,
                                ),
                                trailing: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: Text(
                                       appo.isEmpty
                                            ? 0.toString()
                                            : appo.length
                                                .toString())),
                              );
                            }),

                        const Divider(
                          thickness: 1,
                        ),
                        //cancelled
                        Query(
                            options: QueryOptions(
                              document: gql(Myquery.doc_cance_appoi),
                              variables: {
                                "id": Get.find<SplashController>()
                                    .prefs
                                    .getInt("id")
                              },
                            ),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.hasException) {
                                return const SizedBox();
                              }
                              if (result.isLoading) {
                                return const SizedBox();
                              }
                              if (result.data!.isEmpty) {
                                return const SizedBox();
                              }
                              return ListTile(
                                title: const Text("Cancelled"),
                                leading: const FaIcon(
                                  FontAwesomeIcons.cancel,
                                  color: Colors.red,
                                ),
                                trailing: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: Text(
                                        result.data!["appointments"].length == 0
                                            ? 0.toString()
                                            : result
                                                .data!["appointments"].length
                                                .toString())),
                              );
                            }),
                      ],
                    ),
                  ),
                  // earning
                  Container(
                      width: Get.width,

                      margin:
                          const EdgeInsets.only(top: 20, right: 10, left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Monthly Earning",
                              style: TextStyle(
                                  color: Constants.primcolor, fontSize: 18),
                            ),
                          ),
                          SfCartesianChart(
                              // Initialize category axis
                              primaryXAxis: CategoryAxis(),
                              series: <LineSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    // Bind data source
                                    dataSource: <SalesData>[
                                      SalesData('Jan', 35),
                                      SalesData('Feb', 28),
                                      SalesData('Mar', 34),
                                      SalesData('Apr', 32),
                                      SalesData('May', 40)
                                    ],
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales)
                              ]),
                        ],
                      ))
                ],
              ),
            );
          },
        )
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
