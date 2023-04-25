import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_doctor_et/screens/doctor/blog/addblog.dart';
import 'package:hakime_doctor_et/screens/doctor/blog/widgets/dblog_card.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/cool_loading.dart';

class Dblog extends StatelessWidget {
  const Dblog({Key? key}) : super(key: key);

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
            "My Blogs",
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("delet all"),
                    onTap: () async {
                      EmojiAlert(
                        alertTitle: const Text("Are you sure?",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        description: Column(
                          children: const [
                            Text("do you want to delete all your blogs?"),
                          ],
                        ),
                        enableMainButton: true,
                        mainButtonColor: Constants.primcolor,
                        onMainButtonPressed: () {},
                        cancelable: true,
                        emojiType: EMOJI_TYPE.SAD,
                        height: 260,
                        mainButtonText: const Text("OK"),
                        animationType: ANIMATION_TYPE.ROTATION,
                      ).displayAlert(context);
                    },
                  )
                ];
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Get.toNamed("/daddblog");
            Get.bottomSheet(
                isScrollControlled: true,
                Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20))),
                  child: BottomSheet(
                    onClosing: () {},
                    builder: (context) {
                      return AnimatedContainer(
                          duration: const Duration(seconds: 10),
                          height: Get.height / 1.2,
                          child: AddBlog());
                    },
                  ),
                ));
          },
          backgroundColor: Constants.primcolor,
          tooltip: "Post blog",
          child: const FaIcon(
            FontAwesomeIcons.add,
            color: Colors.white,
          ),
        ),
        body: Query(
          options: QueryOptions(
              document: gql(Myquery.doc_blog),
              variables: {
                "id": Get.find<SplashController>().prefs.getInt("id")
              },
              pollInterval: const Duration(seconds: 10)),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(
                child: cool_loding(),
              );
            }
            List? blogs = result.data!["blogs"];
            if (blogs!.isEmpty) {
              return const Center(
                child: Text("You dont have any blogs yet"),
              );
            }
            return AnimationLimiter(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      return Mutation(
                        options: MutationOptions(
                          document: gql(Mymutation.delete_blog),
                        ),
                        builder: (runMutation, result) {
                          if (result!.isLoading) {
                            blogs.removeAt(index);
                            return const Center(
                              child: cool_loding(),
                            );
                          }
                          return AnimationConfiguration.staggeredList(
                              duration: const Duration(milliseconds: 200),
                              position: index,
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Dismissible(
                                      direction: DismissDirection.horizontal,
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          runMutation(
                                              {"id": blogs[index]["id"]});
                                        }
                                      },
                                      child: DBlogCard(
                                        id: blogs[index]["id"],
                                        image: blogs[index]["theImage"]["url"],
                                        title: blogs[index]["title"],
                                        sub_title: blogs[index]["sub_title"],
                                        content: blogs[index]["content"],
                                        like: blogs[index]["like"],
                                      ),
                                    ),
                                  )));
                        },
                      );
                    }));
          },
        ));
  }
}
