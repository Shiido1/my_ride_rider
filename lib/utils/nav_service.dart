// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_ride/constants/session_manager.dart';
import 'package:my_ride/states/auth_state.dart';
import 'package:provider/provider.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> logOut() async {
    // LocalStorage _appLocalStorage = LocalStorage();
    await SessionManager.instance.logOut();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false);

    authProvider.token = "";
    // await _appLocalStorage.store("access_token", "");

    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil("/signin", (Route r) => r == null);
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }

  BuildContext? getAppContext() {
    return navigatorKey.currentContext;
  }
}
