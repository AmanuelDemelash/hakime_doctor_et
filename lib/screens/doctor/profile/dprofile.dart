import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../apiservice/myquery.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';

class Dprofile extends StatelessWidget {
  Dprofile({Key? key}) : super(key: key);

  int id = Get.find<SplashController>().prefs.getInt("id");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
        title: const Text(
          "profile",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // profile pic
            Query(
              options: QueryOptions(
                document: gql(Myquery.doc_pro),
                variables: {
                  "id": id,
                },
                pollInterval: const Duration(seconds: 10),
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return Container(
                    width: Get.width,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(80))),
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 100,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                var doc = result.data!["doctors_by_pk"];
                return Container(
                  width: Get.width,
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(80))),
                  child: Column(
                    children: [
                      // PROFILE PIC
                      Stack(children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(doc["profile_image"]["url"]),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants.primcolor),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.white,
                                    size: 13,
                                  )),
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "DR. ${doc["full_name"]}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${doc["user_name"]}",
                        style: const TextStyle(color: Colors.black54),
                      )
                    ],
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              ),
            ),

            //edit account
            ListTile(
              onTap: () => Get.toNamed("/deditprofile"),
              leading: const Icon(Icons.person),
              title: const Text("Edit Profile info"),
              trailing: const FaIcon(FontAwesomeIcons.angleRight),
            ),
            const ListTile(
              leading: FaIcon(FontAwesomeIcons.clock),
              title: Text("Avaliable time"),
              trailing: FaIcon(FontAwesomeIcons.angleRight),
            ),
            //experiance
            ListTile(
              onTap: () {
                Get.toNamed("/dexperiance");
              },
              leading: const Icon(
                Icons.history,
              ),
              title: const Text(
                "Expeiance",
              ),
              trailing: const FaIcon(FontAwesomeIcons.angleRight),
            ),
            //Packages
            ListTile(
              onTap: () {
                Get.toNamed("/dpackage");
              },
              leading: const Icon(
                Icons.money,
              ),
              title: const Text(
                "Packages",
              ),
              trailing: const FaIcon(FontAwesomeIcons.angleRight),
            ),
            // license
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.picture_as_pdf,
              ),
              title: const Text(
                "My License",
              ),
              trailing: const FaIcon(FontAwesomeIcons.angleRight),
            ),
          ],
        ),
      ),
    );
  }
}
