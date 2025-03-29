import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Pallete.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.primaryColor
    ),
  );
}