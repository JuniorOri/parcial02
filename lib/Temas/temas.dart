import 'package:flutter/material.dart';

class AppTemas {
  static const Color primary = Color.fromARGB(255, 9, 34, 197);
  static final lightTheme = ThemeData.light().copyWith(
      //Color primario
      primaryColor: Color.fromARGB(255, 64, 179, 255),
      //tema del AppBar
      appBarTheme: const AppBarTheme(backgroundColor: primary, elevation: 10));
}
