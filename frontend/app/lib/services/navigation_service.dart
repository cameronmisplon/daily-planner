import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndMakeRoot(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  Future<dynamic> maybePop({dynamic arguments}) {
    return navigatorKey.currentState!.maybePop(arguments);
  }

  void popTo(String routeName) {
    return navigatorKey.currentState!.popUntil(
          (route) {
        return route.settings.name == routeName;
      },
    );
  }
}