import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.lightBlueAccent,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    primaryColor: primaryClr,
    //scaffoldBackgroundColor: Colors.teal,
    dialogBackgroundColor: primaryClr,
    scaffoldBackgroundColor: white,
    cardColor: Colors.black,
    textTheme: TextTheme(
        headlineLarge: headingStyle(Colors.black),
        headlineMedium: subHeadingStyle(Colors.black)),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: darkHeaderClr,
      foregroundColor: darkGreyClr,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    primaryColor: darkGreyClr,
    //scaffoldBackgroundColor: Colors.teal,
    dialogBackgroundColor: darkGreyClr,
    scaffoldBackgroundColor: darkGreyClr,
    cardColor: Colors.white,
    textTheme: TextTheme(
        headlineLarge: headingStyle(Colors.white),
        headlineMedium: subHeadingStyle(Colors.white)),
    brightness: Brightness.dark,
  );
}

TextStyle headingStyle(color) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: color,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle subHeadingStyle(color) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: color,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ));
}

TextStyle get body1Style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ));
}

TextStyle get body2Style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ));
}
