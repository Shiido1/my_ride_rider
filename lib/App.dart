import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/pages/home/home.dart';
import 'package:my_ride/pages/onboarding/onboarding.dart';
import 'package:my_ride/routes/routes.dart';
import 'package:my_ride/schemas/user.dart';
import 'package:my_ride/states/auth_state.dart';
import 'package:my_ride/states/trip_state.dart';
import 'package:my_ride/utils/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants/session_manager.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(SessionManager.instance.isLoggedIn.toString());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
      ],
      child: MaterialApp(
        title: 'My Ride',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primary,
          ),
        ),
        home: SessionManager.instance.isLoggedIn
            ? ResponsiveSizer(builder: (context, orientation, screenType) {
                return HomePage();
              })
            : ResponsiveSizer(
                builder: (context, orientation, screenType) {
                  return FutureBuilder<dynamic>(
                    future: fetchConfirmationData(context),
                    builder: (buildContext, snapshot) {
                      if (snapshot.hasData) {
                        /// Check if the user has a persisted authentication data
                        if (snapshot.data["access_token"] != null) {
                          if (checkAuthenticated(snapshot.data)) {
                            return HomePage();
                          }
                        }
                        return const OnboardingPage();
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
      ),
    );
  }

  bool checkAuthenticated(data) {
    //debugPrint("checkAuthenticated");

    if (data["token"] != null &&
        data["user"] != null &&
        data["token"] != "" &&
        data["user"] != "") return true;

    // debugPrint("checkAuthenticated1");

    return false;
  }

  Future<Map<String, dynamic>> fetchConfirmationData(
      BuildContext context) async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      String? accessToken = "";
      bool isAuthenticated = false;
      User user = User();

      try {
        dynamic _userid = await LocalStorage().fetch("userid");
        accessToken = await (LocalStorage().fetch("token")) ?? "";

        if (_userid != null) {
          user = User.fromJson(Map<String, dynamic>.from(_userid));
          context.read<AuthProvider>().user =
              Map<String, dynamic>.from(_userid);
        }
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
