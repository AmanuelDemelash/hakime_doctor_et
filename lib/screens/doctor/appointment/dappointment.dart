
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import 'widgets/appointment_card_shimmer.dart';

class Dappointment extends StatelessWidget {
  Dappointment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.whitesmoke,
              title: const Text(
                "Appointment",
                style: TextStyle(color: Colors.black),
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    color: Colors.black,
                  )),
              elevation: 0,
              bottom: const TabBar(
                indicatorWeight: 3,
                indicatorColor: Constants.primcolor,
                isScrollable: true,
                labelColor: Constants.primcolor,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(
                    text: "New",
                  ),
                  Tab(
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Complated",
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              // new appointment
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Query(
                  options: QueryOptions(
                      document: gql(Myquery.doc_new_appointments),
                      variables: {"id":Get.find<SplashController>().prefs.getInt("id")},
                      pollInterval: const Duration(seconds: 10)),
                  builder: (result, {fetchMore, refetch}) {
                    if(result.hasException){
                      print(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const appointment_card_shimmer();
                        },
                      );
                    }
                    List? appointments = result.data!["appointments"];
                    if (appointments!.isEmpty) {
                      return SizedBox(
                        width: Get.width,
                        height: Get.height / 1.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage("assets/images/no_data.png"),
                              width: 150,
                              height: 150,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("No new appointment!"),
                          ],
                        ),
                      );
                    }

                    return AnimationLimiter(
                        child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 200),
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  width: Get.width,
                                  height: 80,
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 10,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: ListTile(
                                      onTap: () => Get.toNamed("/dappdetail",
                                          arguments: {
                                            "pat_id":appointments[index]["patient"]["id"],
                                          "user_id":appointments[index]["user"]["id"],
                                            "user_name":appointments[index]["user"]["full_name"],
                                            "user_sex":appointments[index]["user"]["sex"],
                                            "user_phone":appointments[index]["user"]["phone_number"],
                                          "appointment_id":appointments[index]
                                          ["id"],
                                            "doc_name":appointments[index]["doctor"]["full_name"],
                                            "doc_sep":appointments[index]["doctor"]["speciallities"]["speciallity_name"],
                                            "doc_img":appointments[index]["doctor"]["profile_image"]["url"]
                                          }),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(appointments[index]["patient"]
                                              ["full_name"]),
                                          Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.calendar,
                                                color: Constants.primcolor,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(appointments[index]["date"],
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.clock,
                                                color: Constants.primcolor,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Flexible(
                                                child: Text(
                                                    appointments[index]["time"],
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 12)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      leading: const ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.image,
                                              color: Constants.primcolor,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      trailing: Column(
                                        children: [
                                          appointments[index]["package_type"] ==
                                                  "video"
                                              ? Container(
                                                  width: 30,
                                                  height: 30,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Constants.primcolor
                                                          .withOpacity(0.2)),
                                                  child: const Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons.video,
                                                      color:
                                                          Constants.primcolor,
                                                      size: 15,
                                                    ),
                                                  ),
                                                )
                                              : appointments[index]
                                                          ["package_type"] ==
                                                      "voice"
                                                  ? Container(
                                                      width: 30,
                                                      height: 30,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Constants
                                                              .primcolor
                                                              .withOpacity(
                                                                  0.2)),
                                                      child: const FaIcon(
                                                        FontAwesomeIcons
                                                            .microphone,
                                                        color:
                                                            Constants.primcolor,
                                                        size: 15,
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 30,
                                                      height: 30,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Constants
                                                              .primcolor
                                                              .withOpacity(
                                                                  0.2)),
                                                      child: const FaIcon(
                                                        FontAwesomeIcons
                                                            .message,
                                                        color:
                                                            Constants.primcolor,
                                                        size: 15,
                                                      ),
                                                    ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.green.withOpacity(0.1),
                                            ),
                                            child: Text(
                                              appointments[index]["status"],
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ))),
                            ),
                          ),
                        );
                      },
                    ));
                  },
                ),
              ),
              //upcomming
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Query(
                      options: QueryOptions(
                          document: gql(Myquery.doc_upcoming_appointment),
                          variables: {"id":Get.find<SplashController>().prefs.getInt("id")},
                          pollInterval: const Duration(seconds: 10)),
                      builder: (result, {fetchMore, refetch}) {
                        if(result.hasException){
                          print(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const appointment_card_shimmer();
                            },
                          );
                        }

                        List? appointments = result.data!["appointments"];
                        if (appointments!.isEmpty) {
                          return SizedBox(
                            width: Get.width,
                            height: Get.height / 1.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  image:
                                      AssetImage("assets/images/no_data.png"),
                                  width: 150,
                                  height: 150,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("No upcomming appointment!"),
                              ],
                            ),
                          );
                        }

                        return AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                duration: const Duration(milliseconds: 200),
                                position: index,
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: AnimatedContainer(
                                        duration: const Duration(seconds: 2),
                                        width: Get.width,
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: ListTile(
                                            onTap: () =>
                                                Get.toNamed(
                                                "/dappdetail",
                                                arguments: {
                                                  "pat_id":appointments[index]["patient"]["id"],
                                                  "user_id":appointments[index]["user"]["id"],
                                                  "user_name":appointments[index]["user"]["full_name"],
                                                  "user_sex":appointments[index]["user"]["sex"],
                                                  "user_phone":appointments[index]["user"]["phone_number"],
                                                  "appointment_id":appointments[index]["id"],
                                                  "doc_name":appointments[index]["doctor"]["full_name"],
                                                  "doc_sep":appointments[index]["doctor"]["speciallities"]["speciallity_name"],
                                                  "doc_img":appointments[index]["doctor"]["profile_image"]["url"]
                                                }
                                                ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(appointments[index]
                                                        ["patient"]["full_name"]
                                                    .toString()),
                                                Row(
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.calendar,
                                                      color:
                                                          Constants.primcolor,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                        appointments[index]
                                                            ["date"],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 13)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.clock,
                                                      color:
                                                          Constants.primcolor,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                          appointments[index]
                                                              ["time"],
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 13)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            leading: const ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.image,
                                                    color: Constants.primcolor,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            trailing: Column(
                                              children: [
                                                appointments[index]
                                                            ["package_type"] ==
                                                        "video"
                                                    ? Container(
                                                        width: 35,
                                                        height: 35,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Constants
                                                                    .primcolor
                                                                    .withOpacity(
                                                                        0.2)),
                                                        child: const Center(
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .video,
                                                            color: Constants
                                                                .primcolor,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      )
                                                    : appointments[index][
                                                                "package_type"] ==
                                                            "voice"
                                                        ? Container(
                                                            width: 35,
                                                            height: 35,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Constants
                                                                    .primcolor
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: const Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .microphone,
                                                                color: Constants
                                                                    .primcolor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 35,
                                                            height: 35,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Constants
                                                                    .primcolor
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: const Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .message,
                                                                color: Constants
                                                                    .primcolor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                const SizedBox(height: 1),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Text(
                                                    appointments[index]
                                                        ["status"],
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.green),
                                                  ),
                                                )
                                              ],
                                            ))),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })),
              // complated
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Query(
                      options: QueryOptions(
                          document: gql(Myquery.doc_complated_appointment),
                          variables: {"id":Get.find<SplashController>().prefs.getInt("id")},
                          pollInterval: const Duration(seconds: 10)),
                      builder: (result, {fetchMore, refetch}) {
                        if (result.hasException) {
                          print(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const appointment_card_shimmer();
                            },
                          );
                        }

                        List? appointments = result.data!["appointments"];
                        if (appointments!.isEmpty) {
                          return SizedBox(
                            width: Get.width,
                            height: Get.height / 1.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  image:
                                      AssetImage("assets/images/no_data.png"),
                                  width: 150,
                                  height: 150,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("No complated appointment!"),
                              ],
                            ),
                          );
                        }

                        return AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                duration: const Duration(milliseconds: 200),
                                position: index,
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: AnimatedContainer(
                                        duration: const Duration(seconds: 2),
                                        width: Get.width,
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: ListTile(
                                          onTap: () =>Get.toNamed(
                                              "/dappdetail",
                                              arguments: {
                                                "pat_id":appointments[index]["patient"]["id"],
                                                "user_id":appointments[index]["user"]["id"],
                                                "user_name":appointments[index]["user"]["full_name"],
                                                "user_sex":appointments[index]["user"]["sex"],
                                                "user_phone":appointments[index]["user"]["phone_number"],
                                                "appointment_id":appointments[index]
                                                ["id"],
                                                "doc_name":appointments[index]["doctor"]["full_name"],
                                                "doc_sep":appointments[index]["doctor"]["speciallities"]["speciallity_name"],
                                                "doc_img":appointments[index]["doctor"]["profile_image"]["url"]
                                              }
                                          ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(appointments[index]
                                                        ["patient"]["full_name"]
                                                    .toString()),
                                                Row(
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.calendar,
                                                      color:
                                                          Constants.primcolor,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                        appointments[index]
                                                            ["date"],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 13)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.clock,
                                                      color:
                                                          Constants.primcolor,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                          appointments[index]
                                                              ["time"],
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 13)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            leading: const ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.image,
                                                    color: Constants.primcolor,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            trailing: Column(
                                              children: [
                                                appointments[index]
                                                            ["package_type"] ==
                                                        "video"
                                                    ? Container(
                                                        width: 35,
                                                        height: 35,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Constants
                                                                    .primcolor
                                                                    .withOpacity(
                                                                        0.2)),
                                                        child: const Center(
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .video,
                                                            color: Constants
                                                                .primcolor,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      )
                                                    : appointments[index][
                                                                "package_type"] ==
                                                            "voice"
                                                        ? Container(
                                                            width: 35,
                                                            height: 35,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Constants
                                                                    .primcolor
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: const Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .microphone,
                                                                color: Constants
                                                                    .primcolor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 35,
                                                            height: 35,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Constants
                                                                    .primcolor
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: const Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .message,
                                                                color: Constants
                                                                    .primcolor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                const SizedBox(height: 1),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Text(
                                                    appointments[index]
                                                        ["status"],
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.green),
                                                  ),
                                                )
                                              ],
                                            ))),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })),
            ])));
  }
}
