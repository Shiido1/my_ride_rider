import 'package:cached_network_image/cached_network_image.dart';
import 'package:cron/cron.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/constants/firebase_services.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/models/upcoming_trip.dart';
import 'package:my_ride/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/colors.dart';
import '../../constants/session_manager.dart';
import '../../repository/auth_repo.dart';
import '../../widget/text_widget.dart';
import '../trip/schedule_trip_folder/schedule_provider.dart';

class InitialHomePage extends StatefulWidget {
  const InitialHomePage({Key? key}) : super(key: key);

  @override
  State<InitialHomePage> createState() => _InitialHomePageState();
}

class _InitialHomePageState extends State<InitialHomePage> {
  var name;
  DateTime now = DateTime.now();
  ScheduleProvider? _scheduleProvider;
  List<UpcomingTrip>? upcomingTrips;

  @override
  void initState() {
    name = SessionManager.instance.usersData["name"].split(' ');
    name = name[0].trim();
    buildMethod();
    FirebaseMessaging.instance.getToken().then((value) {
      deviceToken = value;
    });
    super.initState();

    firebaseClass.firebasePushNotification(context);
  }

  buildMethod() async {
    final AuthRepo authRepo = AuthRepo();
    _scheduleProvider = Provider.of<ScheduleProvider>(context, listen: false);
    await _scheduleProvider?.getUpcomingTrip(context);

    if (context.read<ScheduleProvider>().upcomingTrips != null) {
      upcomingTrips = context.read<ScheduleProvider>().upcomingTrips;

      for (UpcomingTrip element in upcomingTrips!) {
        DateTime scheduleTime = DateTime.fromMillisecondsSinceEpoch(
            element.tripStartTimestamp! * 1000);
        DateTime thirtyMinutesBefore =
            scheduleTime.subtract(const Duration(minutes: 30));
        // var presentDate = DateTime.parse('2022-11-04 19:30:00.000');
        var presentDate = DateTime.now();

        if (presentDate.toString().substring(0,19) == thirtyMinutesBefore.toString().substring(0,19)) {
        cron.schedule(Schedule.parse('*/1 * * * *'), () async {
            try {
              Map<String, dynamic>? response = await authRepo.sendPushNot({
                "to": deviceToken,
                "notification": {
                  "title": "You have just received a notification",
                  "body":
                      "For your scheduled trip from ${element.pickAddress} to ${element.dropAddress}",
                  "mutable_content": true,
                  "sound": "Tri-tone"
                },
                "data": {
                  "pick_location": element.pickAddress,
                  "drop_location": element.dropAddress,
                  "start_trip": element.tripStartTime,
                }
              });
              if (response != null && response.isNotEmpty) {
              }
            } catch (e, str) {
              debugPrint("Error: $e");
              debugPrint("StackTrace: $str");
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: 'Hello $name',
                        fontSize: 24.sp,
                      ),
                      TextView(
                        text: 'What do you want to do today? ',
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                  SessionManager.instance.usersData["profile_picture"] ==
                              null ||
                          SessionManager
                                  .instance.usersData["profile_picture"] ==
                              ''
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 26,
                          child: Icon(
                            Icons.person,
                            color: AppColors.grey1,
                            size: 23.sp,
                          ),
                        )
                      : CircleAvatar(
                          radius: 28,
                          child: CachedNetworkImage(
                            imageUrl: SessionManager
                                .instance.usersData["profile_picture"],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const CircularProgressIndicator(),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Image.asset(
                'assets/images/home_page.png',
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () => print(
                    '$scheduleNotDate,$schedulePickUpLocationAdd $scheduleDropLocationAdd'),
                child: TextView(
                  text: 'Schedule Ride ',
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(
                height: 0.6.h,
              ),
              TextView(
                text:
                    'Schedule your rides and have drivers come to you without stress. ',
                fontSize: 16.sp,
              ),
              SizedBox(
                height: 4.h,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    contentContainer(
                        text: 'Instant Ride',
                        image: 'assets/images/clock.png',
                        onTap: () => Routers.pushNamed(context, '/home')),
                    SizedBox(
                      width: 3.h,
                    ),
                    contentContainer(
                        text: 'Weekly',
                        image: 'assets/images/timer.png',
                        onTap: () =>
                            Routers.pushNamed(context, '/schedule_page')),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  contentContainer(
                      text: 'Bi-Weekly',
                      image: 'assets/images/timer-pause.png',
                      onTap: () =>
                          Routers.pushNamed(context, '/schedule_page')),
                  SizedBox(
                    width: 3.h,
                  ),
                  contentContainer(
                      text: 'Monthly',
                      image: 'assets/images/calendar.png',
                      onTap: () =>
                          Routers.pushNamed(context, '/schedule_page')),
                ],
              ),
              // SizedBox(
              //   height: 7.h,
              // ),
              // InkWell(
              //   onTap: () => Routers.pushNamed(context, '/schedule_page'),
              //   child: Container(
              //     margin: EdgeInsets.only(left: 2.w, right:2.w),
              //     height: 7.h,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: const BoxDecoration(
              //         shape: BoxShape.rectangle, color: AppColors.primary),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         TextView(
              //           text: 'Instant Ride',
              //           color: AppColors.white,
              //           fontSize: 16.sp,
              //         ),
              //         SizedBox(
              //           width: 3.6.w,
              //         ),
              //         Container(
              //           decoration: BoxDecoration(
              //               color: AppColors.primary,
              //               shape: BoxShape.circle,
              //               border: Border.all(color: AppColors.white)),
              //           child: Icon(
              //             Icons.check,
              //             size: 16.sp,
              //             color: AppColors.white,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 30.sp,
              ),
            ],
          )),
    );
  }

  contentContainer({String? text, String? image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.h,
        padding: EdgeInsets.fromLTRB(10.w, 1.3.w, 10.w, 1.3.w),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.primary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image!),
              SizedBox(height: 1.7.h),
              TextView(
                text: text!,
                fontSize: 14.sp,
                color: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
