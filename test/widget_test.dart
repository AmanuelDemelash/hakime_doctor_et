// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:get/get.dart';
import 'package:hakime_doctor_et/bindings/appbinding.dart';
import 'package:hakime_doctor_et/controllers/splashcontroller.dart';
import 'package:hakime_doctor_et/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Get.put(SplashController());
    await tester.pumpWidget(
        GetMaterialApp(
            initialBinding: AppBinding(),
        home: MyApp(),
          ),
       );
  });
}
