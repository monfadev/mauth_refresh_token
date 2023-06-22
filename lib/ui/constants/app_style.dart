import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'app_string.dart';

class AppStyle {
  /// Font weight
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  /// Style
  static InputDecoration fieldDecoration(String value) => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        hintText: value,
        hintStyle: TextStyle(color: Colors.grey.shade400),
      );

  static ButtonStyle get normalButton =>
      TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), backgroundColor: AppColor.primaryColor, foregroundColor: Colors.white);
  static ButtonStyle get borderButton => TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(color: AppColor.primaryColor)));
  static ButtonStyle get defaultButton => TextButton.styleFrom(backgroundColor: AppColor.primaryColor, shape: const CircleBorder(), foregroundColor: Colors.white);

  static void setStatusBar(String theme, {Color color = Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: theme == AppString.darkText ? Brightness.dark : Brightness.light,
        statusBarColor: color,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Media query
  static double deviceWidth(context) => MediaQuery.of(context).size.width;
  static double deviceHeight(context) => MediaQuery.of(context).size.height;

  static bool isSmallPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height < 700 ? true : false;
  static bool isReallySmallPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height < 600 ? true : false;
  static bool isBigPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height > 1200 ? true : false;

  static MaterialColor primaryCustomSwatch = MaterialColor(0xff3F8A79, {
    50: AppColor.primaryColor,
    100: AppColor.primaryColor,
    200: AppColor.primaryColor,
    300: AppColor.primaryColor,
    400: AppColor.primaryColor,
    500: AppColor.primaryColor,
    600: AppColor.primaryColor,
    700: AppColor.primaryColor,
    800: AppColor.primaryColor,
    900: AppColor.primaryColor,
  });

  static MaterialColor primaryCustomSwatchDark = const MaterialColor(0xff3F8A79, {
    50: Colors.black,
    100: Colors.black,
    200: Colors.black,
    300: Colors.black,
    400: Colors.black,
    500: Colors.black,
    600: Colors.black,
    700: Colors.black,
    800: Colors.black,
    900: Colors.black,
  });
}
