import 'package:calculator_app/view/calculator_view.dart';
import 'package:flutter/material.dart';// Adjust the import based on your file structure

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorView(),
    );
  }
}
