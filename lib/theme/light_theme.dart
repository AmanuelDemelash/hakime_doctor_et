import 'package:flutter/material.dart';

import '../utils/constants.dart';

ThemeData light = ThemeData(
  fontFamily: "myfont",
  useMaterial3: true,
  primaryColor: Constants.primcolor,
  secondaryHeaderColor: Constants.primcolor,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: const Color(0xFF9E9E9E),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Constants.primcolor,
  ),
  scaffoldBackgroundColor: Constants.whitesmoke,
  iconTheme: const IconThemeData(color: Constants.primcolor),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Constants.primcolor)),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: Constants.primcolor),
);
