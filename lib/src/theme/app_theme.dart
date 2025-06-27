import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Color(0xfff0f0f0),
  colorScheme: ColorScheme.light(
    onPrimary: Color(0xff6457FC),
    onSecondary: Color(0xffFFFFFF),
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(
      color: Color(0xff000000),
      fontSize: 60,
      fontWeight: FontWeight.w200,
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Color(0xff1E1E1E),
  colorScheme: ColorScheme.dark(
    onPrimary: Color(0xff6457FC),
    onSecondary: Color(0xff404040),
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(
      color: Color(0xffffffff),
      fontSize: 60,
      fontWeight: FontWeight.w200,
    ),
  ),
);
