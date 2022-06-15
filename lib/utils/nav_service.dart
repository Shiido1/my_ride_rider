import 'package:flutter/material.dart';
import 'package:my_ride/schemas/user.dart';
import 'package:my_ride/states/auth_state.dart';
import 'package:my_ride/utils/local_storage.dart';
import 'package:provider/provider.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> logOut() async {
    LocalStorage _appLocalStorage = LocalStorage();
    AuthProvider authProvider = Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false);

    authProvider.token = "";
    await _appLocalStorage.store("access_token", "");

    return navigatorKey.currentState!.pushNamedAndRemoveUntil("/signin", (Route r) => r == null);
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }


  BuildContext? getAppContext() {
    return navigatorKey.currentContext;
  }
}
