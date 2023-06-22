import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'app_style.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColor.primaryColor,
        primarySwatch: AppStyle.primaryCustomSwatch,
        textButtonTheme: TextButtonThemeData(
            style:
                TextButton.styleFrom(foregroundColor: AppColor.primaryColor)),
        iconTheme: const IconThemeData(color: Colors.black, size: 18),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          iconSize: 20,
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarHeight: 45,
          color: AppColor.primaryColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: AppStyle.medium),
          toolbarTextStyle: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: AppStyle.bold),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
          actionsIconTheme: const IconThemeData(size: 20),
        ),
        textTheme: TextTheme(
          displayLarge:
              TextStyle(fontSize: 57, color: AppColor.fontPrimaryColor),
          displayMedium:
              TextStyle(fontSize: 45, color: AppColor.fontPrimaryColor),
          displaySmall:
              TextStyle(fontSize: 36, color: AppColor.fontPrimaryColor),
          headlineLarge:
              TextStyle(fontSize: 32, color: AppColor.fontPrimaryColor),
          headlineMedium:
              TextStyle(fontSize: 28, color: AppColor.fontPrimaryColor),
          headlineSmall:
              TextStyle(fontSize: 24, color: AppColor.fontPrimaryColor),
          titleLarge: TextStyle(fontSize: 22, color: AppColor.fontPrimaryColor),
          titleMedium:
              TextStyle(fontSize: 16, color: AppColor.fontPrimaryColor),
          titleSmall: TextStyle(fontSize: 14, color: AppColor.fontPrimaryColor),
          labelLarge: TextStyle(fontSize: 14, color: AppColor.fontPrimaryColor),
          labelMedium:
              TextStyle(fontSize: 12, color: AppColor.fontPrimaryColor),
          labelSmall: TextStyle(fontSize: 11, color: AppColor.fontPrimaryColor),
          bodyLarge: TextStyle(fontSize: 16, color: AppColor.fontPrimaryColor),
          bodyMedium: TextStyle(fontSize: 14, color: AppColor.fontPrimaryColor),
          bodySmall: TextStyle(fontSize: 12, color: AppColor.fontPrimaryColor),
        ),
        colorScheme: const ColorScheme.light()
            .copyWith(
              primary: AppColor.primaryColor,
              onPrimary: AppColor.primaryColor,
            )
            .copyWith(
              primary: AppColor.primaryColor,
              secondary: AppColor.primaryColor,
              brightness: Brightness.light,
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
        ),
      );

  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkBackground,
    primaryColor: AppColor.primaryColor,
    primarySwatch: AppStyle.primaryCustomSwatchDark,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColor.primaryColor)),
    iconTheme: const IconThemeData(color: Colors.white, size: 18),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 20,
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      toolbarHeight: 45,
      color: AppColor.primaryColor,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: AppStyle.medium),
      toolbarTextStyle: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: AppStyle.bold),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 20,
      ),
      actionsIconTheme: const IconThemeData(size: 20),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, color: Colors.white),
      displayMedium: TextStyle(fontSize: 45, color: Colors.white),
      displaySmall: TextStyle(fontSize: 36, color: Colors.white),
      headlineLarge: TextStyle(fontSize: 32, color: Colors.white),
      headlineMedium: TextStyle(fontSize: 28, color: Colors.white),
      headlineSmall: TextStyle(fontSize: 24, color: Colors.white),
      titleLarge: TextStyle(fontSize: 22, color: Colors.white),
      titleMedium: TextStyle(fontSize: 16, color: Colors.white),
      titleSmall: TextStyle(fontSize: 14, color: Colors.white),
      labelLarge: TextStyle(fontSize: 14, color: Colors.white),
      labelMedium: TextStyle(fontSize: 12, color: Colors.white),
      labelSmall: TextStyle(fontSize: 11, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12, color: Colors.white),
    ),
    colorScheme: const ColorScheme.light()
        .copyWith(
          primary: AppColor.primaryColor,
          onPrimary: AppColor.primaryColor,
        )
        .copyWith(
          primary: AppColor.primaryColor,
          secondary: AppColor.primaryColor,
          brightness: Brightness.dark,
        ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.primaryColor,
    ),
  );
}
