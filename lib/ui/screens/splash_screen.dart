import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mauth_refresh_token/core/utils/cache/cache_manager.dart';
import 'package:mauth_refresh_token/core/utils/globals/extensions.dart';
import 'package:provider/provider.dart';

import '../../core/utils/globals/navigations.dart';
import '../../core/viewmodels/theme/theme_provider.dart';
import '../constants/app_color.dart';
import '../constants/app_image.dart';
import '../constants/app_string.dart';
import '../constants/app_style.dart';
import '../routes/route_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLogo = 0;
  double opacityText = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      opacityLogo = 1;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      opacityText = 1;
    });
    await Future.delayed(const Duration(seconds: 1));

    Timer(const Duration(seconds: 1), () async {
      final resp = await CacheManager.instance.isLoggedIn();
      await CacheManager.instance.updateTokenFromStorage();
      if (resp ?? false) {
        navigate.pushToRemoveUntil(AppRoute.routeMain);
      } else {
        navigate.pushToRemoveUntil(AppRoute.routeLogin);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProv, _) => Scaffold(
        backgroundColor: themeProv.currentTheme == AppString.darkText ? AppColor.darkBackground : Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: opacityLogo,
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                      AppImage.imgLogo,
                      height: 200,
                      width: AppStyle.deviceWidth(context) - 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: opacityText,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      AppString.titleName,
                      style: themeProv.currentTheme == AppString.darkText
                          ? context.titleLarge!.copyWith(fontWeight: AppStyle.bold, color: Colors.white)
                          : context.headlineSmall!.copyWith(fontWeight: AppStyle.bold),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedOpacity(
                opacity: opacityText,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    AppString.versionApp,
                    style: themeProv.currentTheme == AppString.darkText
                        ? context.bodyMedium!.copyWith(fontWeight: AppStyle.medium, color: Colors.white)
                        : context.bodyMedium!.copyWith(fontWeight: AppStyle.medium),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
