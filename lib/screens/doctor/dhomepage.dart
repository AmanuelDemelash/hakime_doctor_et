import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/doctor_controllers/dhomepagecontroller.dart';
import '../../utils/constants.dart';
import 'blog/dblog.dart';
import 'dashbord/ddashbord.dart';
import 'history/history.dart';

class Dhomepage extends StatelessWidget {
  Dhomepage({super.key});

  final PageController _pageController = PageController(
      initialPage: Get.find<dhomepagecontroller>().current_bnb_item.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whitesmoke,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [Ddashbord(), const Dblog(), Dhistory(), Container()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primcolor,
        elevation: 10,
        child: const FaIcon(
          FontAwesomeIcons.clock,
          color: Colors.white,
        ),
        onPressed: () {
          Get.toNamed("/dappointment");
        },
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
              icons: const [
                Icons.home,
                Icons.post_add,
                Icons.history,
                Icons.more,
              ],
              activeIndex:
                  Get.find<dhomepagecontroller>().current_bnb_item.value,
              iconSize: 27,
              backgroundColor: Constants.primcolor,
              blurEffect: true,
              activeColor: Constants.whitesmoke,
              inactiveColor: Constants.whitesmoke.withOpacity(0.5),
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              leftCornerRadius: 30,
              rightCornerRadius: 30,
              onTap: (index) {
                if (index == 3) {
                  Get.find<dhomepagecontroller>().current_bnb_item.value =
                      index - 1;
                  Get.find<dhomepagecontroller>().get_more_options();
                } else {
                  Get.find<dhomepagecontroller>().current_bnb_item.value =
                      index;

                  _pageController.jumpToPage(index);
                }
              })),
    );
  }
}
