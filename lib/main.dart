import 'package:flutter/material.dart';
import 'package:flutter_calculator/src/theme/app_theme.dart';
import 'package:flutter_calculator/src/view/calculator_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorUI(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
