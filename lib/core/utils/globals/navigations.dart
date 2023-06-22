import 'package:flutter/material.dart';

final navigate = Navigations.instance;

class Navigations {
  /// [Example Singleton Pattern]
  Navigations._private();

  static Navigations instance = Navigations._private();

  factory Navigations() {
    return instance;
  }

  /// Global key to use in navigator
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigating to some screen using [routeName] and optional
  /// argument [data]
  Future<dynamic> pushTo(String routeName, {dynamic data}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: data);
  }

  Future<dynamic> pushToReplacement(String routeName, {dynamic data}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: data);
  }

  /// Navigating to some screen using [routeName] and optional
  /// argument [data], this function include clear all navigation stack
  Future<dynamic> pushToRemoveUntil(String routeName, {dynamic data}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: data);
  }

  /// Navigating back using pop,
  /// with optional argument [data]
  dynamic pop({dynamic data}) {
    return navigatorKey.currentState!.pop(data);
  }
}
