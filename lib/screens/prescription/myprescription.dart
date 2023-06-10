
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_doctor_et/apiservice/myquery.dart';
import 'package:hakime_doctor_et/controllers/splashcontroller.dart';
import 'package:hakime_doctor_et/widgets/cool_loading.dart';
import '../../utils/constants.dart';
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
              color: Constants.primcolor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("My prescriptions",style: TextStyle(color: Colors.white),),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(ClipRRect(
                      borderRadius:const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      child: BottomSheet(onClosing:() {

                      }, builder:(context) {
                      return Column(
                        children: [
                          const SizedBox(height: 6,),
                          const Text("My patients",style: TextStyle(fontSize:18),),
                        Query(options: QueryOptions(document: gql(Myquery.doc_user),
                        variables: {
                        "id":Get.find<SplashController>().prefs.getInt("id")
                        }
                        ), builder:(result, {fetchMore, refetch}) {
                        if(result.hasException){

                        }
                        if(result.isLoading){
                        return const Center(child: cool_loding(),);
                        }
                        List? appointments = result.data!["appointments"];
                        if(appointments!.isEmpty){
                        return const
                        Text("you don't have any patient yet!");
                        }
                        return 
                          Expanded(
                            child: ListView.builder(
                        itemCount: appointments.length,
                        padding:const EdgeInsets.all(20),
                        itemBuilder:(context, index){
                        return ListTile(
                          onTap: () async{
                            Get.back();
                            Get.toNamed(
                                "/writeprep",
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
                            );

                          },
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Constants.primcolor.withOpacity(0.5),
                              shape: BoxShape.circle
                            ),
                            child:const Center(child:Icon(Icons.person)),
                          ),
                          title:Text(appointments[index]["user"]["full_name"]),
                          subtitle:Text(appointments[index]["user"]["sex"]),
                        );
                        },),
                          );

                        },)

                        ],
                      );

                      },),
                    ));

                  },
                  child: Container(
                    padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Constants.whitesmoke,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child:Row(
                      children:const[
                         Text("Add new",style: TextStyle(color: Colors.black),),
                         SizedBox(width: 10,),
                        FaIcon(FontAwesomeIcons.prescription,color: Colors.black,size: 14,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //prescrip
          Query(options: QueryOptions(document: gql(Myquery.myprescription),
            variables: {
            "id":Get.find<SplashController>().prefs.getInt("id")
            }
          ),
              builder:(result, {fetchMore, refetch}) {
            if(result.hasException){
              print(result.exception.toString());
            }
            if(result.isLoading){
              return const Center(child: cool_loding());
            }
            List? presc=result.data!["prescriptions"];
            if(presc!.isEmpty){
              return Container(
                height: Get.height/2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const[
                    FaIcon(FontAwesomeIcons.prescription,color: Constants.primcolor,size:40,),
                    Text('No prescription yet!',style: TextStyle(color: Colors.black54),)
                  ],
                ),
              );
            }
            return   Expanded(
              child: ListView.builder(
                itemCount:presc.length,
                itemBuilder:(context, index) {
                  return Container(
                    width: Get.width,
                    margin:const EdgeInsets.only(top: 10,left: 10,right: 10),
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
                              Text(presc[index]["created_at"].toString().substring(5,7),style:const TextStyle(fontSize: 25,color: Constants.primcolor),),
                              Text(presc[index]["created_at"].toString().substring(0,4))
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              const SizedBox(height: 10,),
                              const Text("Prescription",style: TextStyle(
                                fontWeight: FontWeight.bold,color: Constants.primcolor,
                              ),),
                             const Text("for",style: TextStyle(
                                color: Colors.black54,
                              ),),
                              Text(presc[index]["user"]["full_name"]),
                              Text(presc[index]["user"]["sex"]),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  const Icon(Icons.medication,size: 17,),
                                  const SizedBox(width: 10,),
                                  Text(presc[index]["prescribed_medicines"].length.toString())
                                ],
                              ),
                              const SizedBox(height: 10,)
                            ],
                          ),
                        ),
                        const FaIcon(FontAwesomeIcons.angleRight,color: Constants.primcolor,),
                        const SizedBox(width: 15,)
                      ],
                    ),
                  );

                },),
            );
              }
              ,)

        ],
      ),
    );
  }
}
