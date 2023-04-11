import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const TextStyle h1Style = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle h2Style = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle h3Style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle msgError = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.red,
  );
  static const TextStyle inputLabelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const TextStyle inputStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
