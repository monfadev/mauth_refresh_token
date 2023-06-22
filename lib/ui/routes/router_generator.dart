import 'package:flutter/material.dart';
import 'package:mauth_refresh_token/ui/screens/auth/login_screen.dart';
import 'package:mauth_refresh_token/ui/screens/main_screen.dart';

import '../screens/splash_screen.dart';
import 'route_list.dart';

class RouterGenerator {
  /// Initializing route
  static Route<dynamic>? generate(RouteSettings settings) {
    /// Declaring argumen route
    final args = settings.arguments;
    switch (settings.name) {
      /// Splash group
      case AppRoute.routeSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: AppRoute.routeSplash),
        );

      case AppRoute.routeLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: AppRoute.routeLogin),
        );

      case AppRoute.routeMain:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: const RouteSettings(name: AppRoute.routeMain),
        );
    }
    return null;
  }
}
