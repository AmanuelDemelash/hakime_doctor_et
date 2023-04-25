import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../controllers/doctor_controllers/blog_controller.dart';
import '../../../controllers/doctor_controllers/dprofilecontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';

class AddBlog extends StatelessWidget {
  AddBlog({super.key});

  final _formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // blog image
                  Obx(
                    () => GestureDetector(
                      onTap: () => Get.find<BlogController>().get_tubnail(),
                      child: Container(
                        width: Get.width,
                        height: 200,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Get.find<BlogController>().is_image.value
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: FileImage(
                                      Get.find<BlogController>().image.value),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(FontAwesomeIcons.image),
                                  Text(
                                    "add tumbnail",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              )),
                      ),
                    ),
                  ),

                  // title
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Title*"),
                  ),
                  TextFormField(
                    controller: title,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Get.find<dprofilecontroller>()
                            .customsnack("add content");
                      } else {
                        return null;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "title",
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.white),
                  ),
                  // subtitle
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("SubTitle*"),
                  ),
                  TextFormField(
                    controller: subtitle,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Get.find<dprofilecontroller>()
                            .customsnack("add content");
                      } else {
                        return null;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "subtitle",
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.white),
                  ),
                  //blog containt
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Content*"),
                  ),
                  TextFormField(
                    controller: content,
                    keyboardType: TextInputType.text,
                    maxLength: 10000,
                    maxLines: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Get.find<dprofilecontroller>()
                            .customsnack("add content");
                      } else {
                        return null;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "content",
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.white),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Mutation(
                    options: MutationOptions(
                      document: gql(Mymutation.insert_blog),
                      onCompleted: (data) {
                        Get.find<BlogController>().is_posting.value = false;
                        Get.back();
                      },
                    ),
                    builder: (runMutation, result) {
                      if (result!.hasException) {
                        print(result.exception.toString());
                      }
                      return Mutation(
                        options: MutationOptions(
                          document: gql(Mymutation.uploadfile),
                          onCompleted: (data) {
                            // rum mutation of add blog
                            if (data!.isNotEmpty) {
                              runMutation({
                                "image": data["uploadImage"]["id"],
                                "title": title.text.toString(),
                                "sub_title": subtitle.text.toString(),
                                "content": content.text.toString(),
                                "doctor_id": Get.find<SplashController>()
                                    .prefs
                                    .getInt("id")
                              });
                            } else {
                              Get.find<BlogController>().is_posting.value =
                                  false;
                              Get.find<dprofilecontroller>()
                                  .customsnack("uploading tumbnail faild...");
                            }
                          },
                        ),
                        builder: (runMutation, result) {
                          if (result!.hasException) {
                            print(result.exception.toString());
                          }
                          if (result.isLoading) {
                            Get.find<BlogController>().is_posting.value = true;
                          }
                          return Container(
                            width: Get.width,
                            margin: const EdgeInsets.all(15),
                            child: Obx(() => ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    onPressed: () {
                                      _formkey.currentState!.save();
                                      if (_formkey.currentState!.validate()) {
                                        if (Get.find<BlogController>()
                                                .tubnil_picture_base64
                                                .value ==
                                            "") {
                                          Get.find<dprofilecontroller>()
                                              .customsnack(
                                                  "please upload your blog tumbnail ");
                                        } else {
                                          //run mutation of tumbnail
                                          runMutation({
                                            "base64": Get.find<BlogController>()
                                                .tubnil_picture_base64
                                                .value
                                          });
                                        }
                                      }
                                    },
                                    child: Get.find<BlogController>()
                                            .is_posting
                                            .value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              ButtonSpinner(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("posting")
                                            ],
                                          )
                                        : const Text("Post"),
                                  ),
                                )),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
