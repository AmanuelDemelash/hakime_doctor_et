import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../apiservice/mymutation.dart';
import '../../../apiservice/myquery.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/cool_loading.dart';
import 'widgets/notificatin_shimmer.dart';
import 'widgets/notification_card.dart';

class Dnotifiction extends StatefulWidget {
  const Dnotifiction({super.key});

  @override
  State<Dnotifiction> createState() => _DnotifictionState();
}

class _DnotifictionState extends State<Dnotifiction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.whitesmoke,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: Query(
        options: QueryOptions(
            document: gql(Myquery.doc_notification),
            variables: {"id": Get.find<SplashController>().prefs.getInt("id")}),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            // return ListView.builder(
            //   itemBuilder: (context, index) {
            //     return const notification_shimmer();
            //   },
            // );
          }
          if (result.isLoading) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return const notification_shimmer();
              },
            );
          }
          List? notific = result.data!["notifications"];
          if (notific!.isEmpty) {
            return const Center(child: Text("No notification"));
          }

          return SizedBox(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notific.length,
              itemBuilder: (context, index) {
                return Mutation(
                  options: MutationOptions(
                    document: gql(Mymutation.delete_notification),
                  ),
                  builder: (runMutation, result) {
                    if (result!.isLoading) {
                      return const cool_loding();
                    }
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        runMutation({"id": notific[index]["id"]});
                        setState(() {
                          notific.removeAt(index);
                        });
                      },
                      child: notification_card(
                        title: notific[index]["title"],
                        desc: notific[index]["description"],
                        type: notific[index]["type"],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
