
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/constants.dart';
import 'package:get/get.dart';

class Myprescription extends StatelessWidget {
  const Myprescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        title: const Text(
          "Prescriptions",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )
        ),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: 60,
            padding:const EdgeInsets.only(left: 10,right: 10),
            decoration:const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("My prescriptions",style: TextStyle(color: Constants.primcolor),),
                Container(
                  padding:const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Constants.primcolor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Row(
                    children:const[
                       Text("Add new",style: TextStyle(color: Colors.white),),
                       SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.download,color: Colors.white,size: 14,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder:(context, index) {
                return Container(
                  width: Get.width,
                  height: 120,
                  margin:const EdgeInsets.all(10),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width:80,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("12",style: TextStyle(fontSize: 20),),
                            Text("2023")
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:const[
                            SizedBox(height: 10,),
                            Text("Prescription",style: TextStyle(
                              fontWeight: FontWeight.bold,color: Constants.primcolor,
                            ),),
                            Text("for",style: TextStyle(
                              color: Colors.black54,
                            ),),
                            Text("Amanuel demelash"),
                             Text("male"),
                          ],
                        ),
                      ),
                      const FaIcon(FontAwesomeIcons.angleRight,color: Constants.primcolor,),
                      const SizedBox(width: 15,)
                    ],
                  ),
                );

            },),
          )
        ],
      ),
    );
  }
}
