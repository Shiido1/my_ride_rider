// ignore_for_file: file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/pages/home/home.dart';
import 'package:my_ride/pages/onboarding/onboarding.dart';
import 'package:my_ride/routes/routes.dart';
import 'package:my_ride/schemas/user.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants/session_manager.dart';
import 'models/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.getProviders,
      builder: (_, __) => ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'My Ride',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primary,
              ),
            ),
            home: SessionManager.instance.isLoggedIn
                ? ResponsiveSizer(builder: (context, orientation, screenType) {
                    return const HomePage();
                  })
                : ResponsiveSizer(
                    builder: (context, orientation, screenType) {
                      return FutureBuilder<dynamic>(
                        future: fetchConfirmationData(context),
                        builder: (buildContext, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data["access_token"] != null) {
                              if (checkAuthenticated(snapshot.data)) {
                                return const HomePage();
                              }
                            }
                            return const OnBoardingPage();
                          } else {
                            return Stack(
                              children: <Widget>[
                                Container(color: AppColors.primary),
                                Center(
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    height: 100,
                                    width: 500,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    },
                  ),
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }

  bool checkAuthenticated(data) {
    if (data["token"] != null &&
        data["user"] != null &&
        data["token"] != "" &&
        data["user"] != "") return true;

    return false;
  }

  Future<Map<String, dynamic>> fetchConfirmationData(
      BuildContext context) async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      String? accessToken = "";
      bool isAuthenticated = false;
      User user = User();

      try {
        dynamic _userid = SessionManager.instance.uuidData;
        accessToken = SessionManager.instance.authToken;

        if (_userid != null) {}
      } catch (e, str) {
        debugPrint("$e");
        debugPrint("StackTrace$str");
      }

      return {
        "token": accessToken,
        "user": user,
      };
    });
  }
}
