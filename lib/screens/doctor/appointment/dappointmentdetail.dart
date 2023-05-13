import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/doctor_controllers/dappointmentcontroller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';
import '../../../widgets/loading.dart';
import 'widgets/appointment_detail_shimmer.dart';

class Dappointmentdetail extends StatelessWidget {
  Dappointmentdetail({Key? key}) : super(key: key);


  Map<String,dynamic> data=Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whitesmoke,
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        title: const Text(
          "Appointment",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
       actions: [

       ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Get.toNamed("/writeprep",arguments: {
            "user-id":data["user_id"],
            "appo_id":data["appointment_id"]
          });
      }, tooltip: "Write prescription",
      child:const FaIcon(FontAwesomeIcons.pen,color: Colors.white,)),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Query(
            options: QueryOptions(
              document: gql(Myquery.appointment_detail),
              variables: {"id":data["appointment_id"]},
              pollInterval: const Duration(seconds: 10),
            ),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const appointment_detail_shimmer();
              }
              Map<String, dynamic>? appointment =
                  result.data!["appointments_by_pk"];

              if (appointment.isNull) {
                return SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: const Center(
                    child: loading(),
                  ),
                );
              }
              return AnimationLimiter(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // patient info
                        AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 200),
                          position: 0,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Container(
                                width: Get.width,
                                height: 180,
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Patient Information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: FaIcon(
                                            FontAwesomeIcons.image,
                                            size: 14,
                                          )),
                                          imageUrl: '',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Name: "),
                                              Text(
                                                appointment!["patient"]
                                                    ["full_name"],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Age: "),
                                              Text(
                                                appointment["patient"]["age"]
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Gender: "),
                                              Text(
                                                appointment["user"]["sex"],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ])
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // appoint info
                        AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 200),
                          position: 1,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Container(
                                width: Get.width,
                                height: 180,
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Appointment Information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.check,
                                          color: Constants.primcolor,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(appointment["package_type"] +
                                            " consultancy")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.calendar,
                                          color: Constants.primcolor,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(appointment["date"])
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.clock,
                                          color: Constants.primcolor,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(appointment["time"])
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // probblem
                        AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 200),
                          position: 1,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Container(
                                width: Get.width,
                                height: 200,
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Problem",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Flexible(
                                        child: Text(
                                            appointment["patient"]["problem"]))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        //package
                        AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 200),
                          position: 2,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Container(
                                width: Get.width,
                                height: 180,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "Appointment Package",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    appointment["package_type"] == "video"
                                        ? Container(
                                            width: Get.width,
                                            margin: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(15),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Constants
                                                              .primcolor
                                                              .withOpacity(
                                                                  0.4)),
                                                      child: const Center(
                                                          child: FaIcon(
                                                        FontAwesomeIcons.video,
                                                        color:
                                                            Constants.primcolor,
                                                      )),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          "Video Call",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "video call with doctor",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      appointment["price"],
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Constants
                                                              .primcolor),
                                                    ),
                                                    const Text(
                                                      "/session",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : appointment["package_type"] == "voice"
                                            ? Container(
                                                width: Get.width,
                                                margin: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 10),
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Constants
                                                                  .primcolor
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: const Center(
                                                              child: FaIcon(
                                                            FontAwesomeIcons
                                                                .microphone,
                                                            color: Constants
                                                                .primcolor,
                                                          )),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              "Voice Call",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "voice call with doctor",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          appointment["price"],
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Constants
                                                                  .primcolor),
                                                        ),
                                                        const Text(
                                                          "/session",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                width: Get.width,
                                                margin: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 10),
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Constants
                                                                  .primcolor
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: const Center(
                                                              child: FaIcon(
                                                            FontAwesomeIcons
                                                                .message,
                                                            color: Constants
                                                                .primcolor,
                                                          )),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              "Chat message",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "Chat with doctor",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          appointment["price"],
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Constants
                                                                  .primcolor),
                                                        ),
                                                        const Text(
                                                          "/session",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // accept and reject
                        appointment["status"] == "pending"
                            ? Mutation(
                                options: MutationOptions(
                                  document: gql(Mymutation.insert_notification),
                                  onError: (error) {},
                                  onCompleted: (data) {
                                    Get.find<dappointmentcontroller>()
                                                .notification_type
                                                .value ==
                                            "cancelled"
                                        ? Get.find<NotificationController>()
                                            .crateNotification(
                                                "Appointment cancelled",
                                                "you rejected the appointment")
                                        : Get.find<NotificationController>()
                                            .crateNotification(
                                                "Appointment accepted",
                                                "you just accept the appointment please follow the appointment");

                                    Get.find<dappointmentcontroller>()
                                        .notification_type
                                        .value = "";
                                    Get.find<dappointmentcontroller>()
                                            .is_updating_appoi_status
                                            .value ==
                                        false;

                                    Get.back();
                                  },
                                ),
                                builder: (runMutation, result) {
                                  if (result!.hasException) {
                                    print(result.exception.toString());
                                  }
                                  return Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Mutation(
                                        options: MutationOptions(
                                          document: gql(
                                              Mymutation.update_appo_statuss),
                                          onError: (error) {},
                                          onCompleted: (data) {
                                            Get.find<dappointmentcontroller>()
                                                .is_updating_appoi_status
                                                .value = false;
                                            Get.find<dappointmentcontroller>()
                                                .is_updating_appoi_status_confirm
                                                .value = false;
                                            // send notification
                                            Get.find<dappointmentcontroller>()
                                                        .notification_type
                                                        .value ==
                                                    "cancelled"
                                                ? Get.find<
                                                        NotificationController>()
                                                    .crateNotification(
                                                        "Appointment canclled",
                                                        "you just canceled appointment")
                                                : Get.find<
                                                        NotificationController>()
                                                    .crateNotification(
                                                        "Appointment confirmed",
                                                        "you confirme the appointment succesfully please follow your appointment");
                                            // run notification mutation
                                            Get.find<dappointmentcontroller>()
                                                        .notification_type
                                                        .value ==
                                                    "cancelled"
                                                ? runMutation({
                                                    "user_id":
                                                        appointment["user"]
                                                            ["id"],
                                                    "title":
                                                        "Appointment Canceled",
                                                    "description":
                                                        "your appointment with ${appointment["doctor"]["full_name"]} on ${appointment["date"]} is canceld. 100% of the fund will be returned to your account",
                                                    "type": Get.find<
                                                            dappointmentcontroller>()
                                                        .notification_type
                                                        .value
                                                  })
                                                : runMutation({
                                                    "user_id":
                                                        appointment["user"]
                                                            ["id"],
                                                    "title":
                                                        "Appointment Accepted",
                                                    "description":
                                                        "your appointment with ${appointment["doctor"]["full_name"]} on ${appointment["date"]} is accepted.",
                                                    "type": Get.find<
                                                            dappointmentcontroller>()
                                                        .notification_type
                                                        .value
                                                  });
                                          },
                                        ),
                                        builder: (runMutation, result) {
                                          if (result!.isLoading) {
                                            Get.find<dappointmentcontroller>()
                                                    .is_updating_appoi_status
                                                    .value
                                                ? Get.find<dappointmentcontroller>()
                                                        .is_updating_appoi_status_confirm
                                                        .value ==
                                                    false
                                                : Get.find<dappointmentcontroller>()
                                                        .is_updating_appoi_status_confirm
                                                        .value ==
                                                    true;
                                          }
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Obx(() => ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .redAccent,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(17)),
                                                          onPressed: () {
                                                            Get.find<
                                                                    dappointmentcontroller>()
                                                                .is_updating_appoi_status
                                                                .value = true;
                                                            runMutation({
                                                              "id":
                                                                  data["appointment_id"],
                                                              "status":
                                                                  "cancelled"
                                                            });
                                                            Get.find<dappointmentcontroller>()
                                                                    .notification_type
                                                                    .value =
                                                                "cancelled";
                                                          },
                                                          child: Get.find<dappointmentcontroller>()
                                                                      .is_updating_appoi_status
                                                                      .value ==
                                                                  true
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    ButtonSpinner(),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                        "Rejecting...")
                                                                  ],
                                                                )
                                                              : const Text(
                                                                  "Reject")),
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Obx(() => ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Constants
                                                                      .primcolor,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(17)),
                                                          onPressed: () {
                                                            Get.find<
                                                                    dappointmentcontroller>()
                                                                .is_updating_appoi_status_confirm
                                                                .value = true;
                                                            runMutation({
                                                              "id":
                                                                  data["appointment_id"],
                                                              "status":
                                                                  "confirmed"
                                                            });
                                                            Get.find<dappointmentcontroller>()
                                                                    .notification_type
                                                                    .value =
                                                                "confirmed";
                                                          },
                                                          child: Get.find<
                                                                      dappointmentcontroller>()
                                                                  .is_updating_appoi_status_confirm
                                                                  .value
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    ButtonSpinner(),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Text(
                                                                        "Accepting...")
                                                                  ],
                                                                )
                                                              : const Text(
                                                                  "Confirm")),
                                                    )),
                                              ),
                                            ],
                                          );
                                        },
                                      ));
                                },
                              )
                            : appointment["status"] == "confirmed"
                                ?
                                // if appointment upcomming show this widget
                                AnimationConfiguration.staggeredList(
                                    position: 4,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      width: Get.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: ElevatedButton.icon(
                                          icon: appointment["package_type"] ==
                                                  "video"
                                              ? const FaIcon(
                                                  FontAwesomeIcons.video,
                                                  size: 15,
                                            color: Colors.white,
                                                )
                                              : appointment["package_type"] ==
                                                      "voice"
                                                  ? const FaIcon(
                                                      FontAwesomeIcons
                                                          .microphone,
                                                      size: 15,
                                            color: Colors.white,
                                                    )
                                                  : const FaIcon(
                                                      FontAwesomeIcons.message,
                                                      size: 15,
                                            color: Colors.white,
                                                    ),
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.all(15)),
                                          onPressed: () async {
                                            // based on appointment type
                                            if (appointment["package_type"] ==
                                                "video") {
                                              Get.toNamed("/ZegoCloudCall",
                                                  arguments: {
                                                    "channel":
                                                        appointment["channel"],
                                                    "photo": appointment[
                                                                "doctor"]
                                                            ["profile_image"]
                                                        ["url"],
                                                    "full_name":
                                                        appointment["doctor"]
                                                            ["full_name"]
                                                  });
                                            } else if (appointment[
                                                    "package_type"] ==
                                                "voice") {
                                              Get.toNamed("/voicecll",
                                                  arguments: {
                                                    "channel":
                                                        appointment["channel"],
                                                    "photo": appointment[
                                                                "doctor"]
                                                            ["profile_image"]
                                                        ["url"],
                                                    "full_name":
                                                        appointment["doctor"]
                                                            ["full_name"],
                                                    "isHost": false
                                                  });
                                            } else {
                                              Get.toNamed("/chatdetail",
                                                  arguments: appointment["user"]
                                                      ["id"]);
                                            }
                                          },
                                          label: appointment["package_type"] ==
                                                  "video"
                                              ? Text(
                                                  "${appointment["package_type"]} call (Start at ${appointment["time"]}")
                                              : appointment["package_type"] ==
                                                      "voice"
                                                  ? Text(
                                                      "${appointment["package_type"]} call (Start at ${appointment["time"]}",style:const TextStyle(color: Colors.white),)
                                                  : Text(
                                                      "${appointment["package_type"]}  (Start at ${appointment["time"]}",style:const TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Text(""),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
