import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class Dhistory extends StatelessWidget {
  const Dhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.whitesmoke,
          title: const Text(
            "History",
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leading: Container(
              margin: const EdgeInsets.all(5),
              child: const Image(
                image: AssetImage("assets/images/logo.png"),
                width: 50,
                height: 50,
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
                text: "Chat",
              ),
              Tab(
                text: "Video call",
              ),
              Tab(
                text: "Voice call",
              )
            ],
          ),
        ),
      ),
    );
  }
}
