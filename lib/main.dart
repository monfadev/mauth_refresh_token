import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mauth_refresh_token/core/utils/cache/cache_manager.dart';
import 'package:mauth_refresh_token/core/viewmodels/auth/user_provider.dart';
import 'package:mauth_refresh_token/ui/constants/app_string.dart';
import 'package:mauth_refresh_token/ui/constants/app_theme.dart';
import 'package:mauth_refresh_token/ui/routes/route_list.dart';
import 'package:provider/provider.dart';

import 'core/utils/globals/navigations.dart';
import 'core/viewmodels/theme/theme_provider.dart';
import 'injector.dart';
import 'ui/routes/router_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  await CacheManager.instance.initialize();

  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  void precacheAssets() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final rawAssets = json.decode(manifestJson) as Map<String, dynamic>;
    final images = rawAssets.keys.where((String key) => key.startsWith('assets/images')).toList();
    final icons = rawAssets.keys.where((String key) => key.startsWith('assets/icons')).toList();
    List<String> assets = [];
    assets.addAll(images);
    assets.addAll(icons);

    for (var asset in assets) {
      try {
        if (asset.contains(".png")) {
          if (mounted) precacheImage(AssetImage(asset), context);
        }
      } catch (e) {
        //
        continue;
      }
    }
  }

  @override
  void didChangeDependencies() {
    precacheAssets();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()..initialized()),
        ChangeNotifierProvider(create: (context) => locator<UserProvider>()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: true,
        title: AppString.titleName,
        navigatorKey: navigate.navigatorKey,
        themeMode: context.watch<ThemeProvider>().themeMode,
        theme: AppTheme.lightThemeData,
        darkTheme: AppTheme.darkThemeData,
        builder: (ctx, child) {
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: MediaQuery.of(ctx).textScaleFactor >= 1.3 ? 1.3 : 1),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            ),
          );
        },
        initialRoute: AppRoute.routeSplash,
        onGenerateRoute: RouterGenerator.generate,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
