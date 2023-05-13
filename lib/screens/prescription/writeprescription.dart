import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hakime_doctor_et/screens/prescription/widgets/addmedicine.dart';
import '../../controllers/doctor_controllers/writeprescriptioncontroller.dart';
import '../../utils/constants.dart';

class WritePrescription extends StatelessWidget {
  const WritePrescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        title: const Text(
          "Write prescription",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //patient
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const ListTile(
                leading: CircleAvatar(
                  radius: 20,
                ),
                title: Text("patent name"),
                subtitle: Text("phone "),
              ),
            ),
            // prescription form
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: Constants.primcolor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Add medicine"),
                  GestureDetector(
                    onTap: () async {
                      Get.bottomSheet(ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return const Addmedicine();
                          },
                        ),
                      ),
                        isScrollControlled: true
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Constants.primcolor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: FaIcon(
                        FontAwesomeIcons.add,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            // list of medicine
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child:Obx(() =>
                  ListView.builder(
                 physics:const  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Get.find<WritrprescriptionController>().medicines.value.length,
                  itemBuilder:(context, index) {
                   if(Get.find<WritrprescriptionController>().medicines.value.isEmpty){
                     return const Text("add medicine");
                   }
                   return ListTile(
                     leading: Text("${index+1}"),
                     title: Text(Get.find<WritrprescriptionController>().medicines.value[index].name),
                     subtitle: Text(Get.find<WritrprescriptionController>().medicines.value[index].strength),
                     trailing: IconButton(onPressed:() {
                       Get.find<WritrprescriptionController>().medicines.value.removeAt(index);

                     }, icon:const FaIcon(FontAwesomeIcons.trash,color: Colors.red,)),
                   );
                  },)
              )
            ),

            const SizedBox(
              height: 60,
            ),
            // submit
            Container(
              width: Get.width,
              height: 50,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
