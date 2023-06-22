import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = const Color(0xff3F8A79);
  static Color secondaryColor = const Color(0xff64B18C);
  static Color strokeColor = const Color(0xffECECEC);

  static Color fontPrimaryColor = const Color(0xff2B2B2B);

  static Color lightBackground = const Color(0xffF5F6FA);
  static Color darkBackground = const Color(0xff202020);

  static Color get shadowColor => Colors.black.withOpacity(.05);
  static BoxShadow get shadow => BoxShadow(color: shadowColor, blurRadius: 5, spreadRadius: 1);
}
