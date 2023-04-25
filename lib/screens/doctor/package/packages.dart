import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/doctor_controllers/dpackagecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';
import '../../../widgets/cool_loading.dart';

class Packages extends StatelessWidget {
  Packages({super.key});

  int id = Get.find<SplashController>().prefs.getInt("id");

  TextEditingController videocontroller = TextEditingController();
  TextEditingController voicecontroller = TextEditingController();
  TextEditingController chatcontroller = TextEditingController();

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
          "Consoltancy packages",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Query(
              options: QueryOptions(
                document: gql(Myquery.doc_package),
                variables: {"id": id},
                onComplete: (data) {},
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: const Center(
                      child: cool_loding(),
                    ),
                  );
                }
                List? package = result.data!["packages"];
                if (package!.isEmpty) {
                  videocontroller.text = "0";
                  voicecontroller.text = "0";
                  chatcontroller.text = "0";
                }

                if (package.isNotEmpty) {
                  voicecontroller.text = package[0]["voice"].toString();
                  Get.find<DpackageController>().voice_cheekbox.value = true;
                  videocontroller.text = package[0]["video"].toString();
                  Get.find<DpackageController>().video_cheekbox.value = true;
                  chatcontroller.text = package[0]["chat"].toString();
                  Get.find<DpackageController>().chat_cheekbox.value = true;
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => ExpansionTile(
                        childrenPadding: const EdgeInsets.all(10),
                        onExpansionChanged: (value) {
                          Get.find<DpackageController>().video_cheekbox.value =
                              value;
                        },
                        title: Text(
                          "Video Consoltancy",
                          style: TextStyle(
                              color: Constants.primcolor.withOpacity(0.6)),
                        ),
                        subtitle: Text(
                          "per/session",
                          style: TextStyle(
                              color: Constants.primcolor.withOpacity(0.4)),
                        ),
                        trailing: IgnorePointer(
                          child: Checkbox(
                            activeColor: Constants.primcolor,
                            value: Get.find<DpackageController>()
                                .video_cheekbox
                                .value,
                            onChanged: (value) {
                              Get.find<DpackageController>()
                                  .video_cheekbox
                                  .value = value!;
                            },
                          ),
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Constants.primcolor.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.video,
                              color: Constants.primcolor,
                            ),
                          ),
                        ),
                        children: [
                          Row(
                            children: [
                              const Text(
                                "ETB",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: videocontroller,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "0.0",
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      fillColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // voice
                    Obx(
                      () => ExpansionTile(
                        onExpansionChanged: (value) {
                          Get.find<DpackageController>().voice_cheekbox.value =
                              value;
                        },
                        childrenPadding: const EdgeInsets.all(15),
                        subtitle: Text(
                          "per/session",
                          style: TextStyle(
                              color: Constants.primcolor.withOpacity(0.4)),
                        ),
                        trailing: IgnorePointer(
                          child: Checkbox(
                            activeColor: Constants.primcolor,
                            value: Get.find<DpackageController>()
                                .voice_cheekbox
                                .value,
                            onChanged: (value) {
                              Get.find<DpackageController>()
                                  .voice_cheekbox
                                  .value = value!;
                            },
                          ),
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Constants.primcolor.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.microphone,
                              color: Constants.primcolor,
                            ),
                          ),
                        ),
                        title: Text(
                          "Voice Consoltancy",
                          style: TextStyle(
                              color: Constants.primcolor.withOpacity(0.6)),
                        ),
                        children: [
                          Row(
                            children: [
                              const Text(
                                "ETB",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: voicecontroller,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "0.0",
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      fillColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // chat
                    Obx(
                      () => ExpansionTile(
                        onExpansionChanged: (value) {
                          Get.find<DpackageController>().chat_cheekbox.value =
                              value;
                        },
                        childrenPadding: const EdgeInsets.all(15),
                        subtitle: Text(
                          "per/session",
                          style: TextStyle(
                              color: Constants.primcolor.withOpacity(0.4)),
                        ),
                        trailing: IgnorePointer(
                          child: Checkbox(
                            activeColor: Constants.primcolor,
                            value: Get.find<DpackageController>()
                                .chat_cheekbox
                                .value,
                            onChanged: (value) {
                              Get.find<DpackageController>()
                                  .chat_cheekbox
                                  .value = value!;
                            },
                          ),
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Constants.primcolor.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.message,
                              color: Constants.primcolor,
                            ),
                          ),
                        ),
                        title: Text(
                          "Chat Consoltancy",
                          style: TextStyle(
                              color: Constants.primcolor.withOpacity(0.6)),
                        ),
                        children: [
                          Row(
                            children: [
                              const Text(
                                "ETB",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: chatcontroller,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "0.0",
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.whitesmoke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      fillColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Mutation(
                      options: MutationOptions(
                        document: gql(package.isEmpty
                            ? Mymutation.insert_package
                            : Mymutation.update_package),
                        onError: (error) {},
                        onCompleted: (data) {
                          Get.find<DpackageController>()
                              .is_updating_package
                              .value = false;
                          Get.back();
                        },
                      ),
                      builder: (runMutation, result) {
                        if (result!.isLoading) {
                          Get.find<DpackageController>()
                              .is_updating_package
                              .value = true;
                        }
                        return Obx(() => Container(
                            width: Get.width,
                            margin: const EdgeInsets.all(15),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  onPressed: () {
                                    if (videocontroller.text.isEmpty) {
                                      videocontroller.text = "0";
                                    } else if (voicecontroller.text.isEmpty) {
                                      voicecontroller.text = "0";
                                    } else if (chatcontroller.text.isEmpty) {
                                      voicecontroller.text = "0";
                                    } else {
                                      runMutation({
                                        "doctor_id": id,
                                        "video":
                                            int.parse(videocontroller.text),
                                        "voice":
                                            int.parse(voicecontroller.text),
                                        "chat": int.parse(chatcontroller.text)
                                      });
                                    }
                                  },
                                  child: Get.find<DpackageController>()
                                          .is_updating_package
                                          .value
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            ButtonSpinner(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Saving...")
                                          ],
                                        )
                                      : const Text("Save"),
                                ))));
                      },
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
