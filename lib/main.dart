import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_doctor_et/screens/prescription/myprescription.dart';
import 'package:hakime_doctor_et/screens/onbording/splash.dart';
import 'package:hakime_doctor_et/screens/prescription/addmedicine.dart';
import 'package:hakime_doctor_et/screens/prescription/writeprescription.dart';
import 'package:hakime_doctor_et/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bindings/appbinding.dart';
import 'screens/auth/forgotpassword.dart';
import 'screens/auth/login.dart';
import 'screens/auth/signup.dart';
import 'screens/auth/verificationcode.dart';
import 'screens/doctor/appointment/dappointment.dart';
import 'screens/doctor/appointment/dappointmentdetail.dart';
import 'screens/doctor/bankinfo/addbankinfo.dart';
import 'screens/doctor/bankinfo/dbankinfo.dart';
import 'screens/doctor/blog/addblog.dart';
import 'screens/doctor/blog/dblog.dart';
import 'screens/doctor/chat/chat_detail.dart';
import 'screens/doctor/chat/voice_call.dart';
import 'screens/doctor/chat/zegocloudcall.dart';
import 'screens/doctor/dhomepage.dart';
import 'screens/doctor/dsignup.dart';
import 'screens/doctor/experiance/addexperiance.dart';
import 'screens/doctor/experiance/experiance.dart';
import 'screens/doctor/notification/dnotification.dart';
import 'screens/doctor/package/packages.dart';
import 'screens/doctor/profile/dprofile.dart';
import 'screens/doctor/profile/edit_profile.dart';
import 'screens/doctor/wallet/dwallet.dart';
import 'screens/doctor/wallet/withdraw.dart';
import 'screens/onbording/onbordscreen.dart';
import 'screens/setting.dart';
import 'theme/light_theme.dart';
import 'translations/apptranslations.dart';

late final prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  prefs = await SharedPreferences.getInstance();
  // notification
  AwesomeNotifications().initialize(
      //set the icon to null if you want to use the default app icon
      'resource://drawable/logo',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Constants.primcolor,
            importance: NotificationImportance.High,
            ledColor: Colors.white),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Constants.primcolor,
          importance: NotificationImportance.High,
          channelDescription: 'Notification channel for schdule',
        ),
      ],
      //Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpLink httpLink = HttpLink("https://hakime-2.hasura.app/v1/graphql",
        defaultHeaders: {"x-hasura-admin-secret": "hakime"});
    final WebSocketLink websocketLink = WebSocketLink(
      "wss://hakime-2.hasura.app/v1/graphql",
      config: const SocketClientConfig(
          autoReconnect: true,
          inactivityTimeout: Duration(seconds: 30),
          headers: {"x-hasura-admin-secret": "hakime"}
      ),
    );
    final Link link = Link.split(
        (request) => request.isSubscription, websocketLink, httpLink);

    var token = prefs.getString("token");
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <$token>',
    );
    final Link main_link = authLink.concat(link);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: main_link,
        // The default store is the InMemoryStofre, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: GetMaterialApp(
        initialBinding: AppBinding(),
        translations: AppTranslations(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRight,
        title: Constants.app_name,
        theme: light,
        initialRoute: "/splash",
        getPages: [
          GetPage(name: "/splash", page: () => Splash()),
          GetPage(name: "/login", page: () => Login()),
          GetPage(name: "/signup", page: () => Signup()),
          GetPage(name: "/forgotpassword", page: () => ForgotPassword()),
          GetPage(name: "/verification", page: () => VerificationCode()),
          GetPage(name: "/onbording", page: () => Onbordscreen()),
          GetPage(name: "/ZegoCloudCall", page: () => ZegoCloudCall()),
          GetPage(
            name: "/voicecll",
            page: () => VoiceCall(),
          ),
          GetPage(name: "/chatdetail", page: () => ChatDetail()),
          GetPage(name: "/dsignup", page: () => Dsignup()),
          GetPage(name: "/dhomepage", page: () => Dhomepage()),
          GetPage(name: "/dappdetail", page: () => Dappointmentdetail()),
          GetPage(name: "/dprofile", page: () => Dprofile()),
          GetPage(name: "/dblog", page: () => Dblog()),
          GetPage(name: "/dbank", page: () => Dbankinfo()),
          GetPage(name: "/dwallet", page: () => Dwallet()),
          GetPage(name: "/dappointment", page: () => Dappointment()),
          GetPage(name: "/deditprofile", page: () => Edit_profile()),
          GetPage(name: "/addbankinfo", page: () => AddBankInfo()),
          GetPage(name: "/dexperiance", page: () => Experiance()),
          GetPage(name: "/daddexp", page: () => AddExperiance()),
          GetPage(name: "/dpackage", page: () => Packages()),
          GetPage(name: "/dwithdraw", page: () => DWithdraw()),
          GetPage(name: "/daddblog", page: () => AddBlog()),
          GetPage(name: "/dnotification", page: () => Dnotifiction()),
          GetPage(name: "/writeprep", page: () =>WritePrescription()),
          GetPage(name: "/presc", page: () =>Myprescription()),
          GetPage(name: "/addmedicin", page: () =>Addmedicine()),
          // both screen
          GetPage(name: "/setting", page: () => Setting()),
        ],
      ),
    );
  }
}
