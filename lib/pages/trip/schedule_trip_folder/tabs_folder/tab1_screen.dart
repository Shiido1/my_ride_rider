// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constants/colors.dart';
import '../../../../widget/text_widget.dart';
import '../schedule_provider.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  getUpTrips(context) => Provider.of<ScheduleProvider>(context, listen: false)
      .getUpcomingTrip(context);

  @override
  void initState() {
    getUpTrips(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(6.w),
            child: SingleChildScrollView(child: Consumer<ScheduleProvider>(
              builder: (_, provider, __) {
                if (provider.upcomingResponse==null) {
                  return const Center(
                    child: SpinKitCubeGrid(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                  );
                }
                if (provider.upcomingResponse?['data'].isEmpty) {
                  return TextView(
                      text: 'No upcoming trips',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600);
                }
                return Column(children: [
                  ...provider.upcomingResponse?['data']
                      .map(
                        (data) => Padding(
                          padding: EdgeInsets.only(bottom: 3.5.w),
                          child: Container(
                              padding: EdgeInsets.all(4.5.w),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 231, 228, 228),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          TextView(
                                            text: 'Date',
                                            fontSize: 16.sp,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            height: .5.h,
                                          ),
                                          TextView(
                                              text:
                                                  data['trip_start_time'] ?? '',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        children: [
                                          TextView(
                                            text: 'Time',
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                          SizedBox(
                                            height: .5.h,
                                          ),
                                          TextView(
                                              text:
                                                  data['cv_trip_start_time'] ??
                                                      '',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 1.w),
                                        child: CircleAvatar(
                                          radius: 25,
                                          child: CachedNetworkImage(
                                            imageUrl: data['userDetail']['data']
                                                    ['profile_picture'] ??
                                                '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                    error) =>
                                                const CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 1.2.w),
                                        child: TextView(
                                          text: data['userDetail']['data']
                                                  ['name'] ??
                                              '',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/boy.png',
                                            scale: 0.6,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                    text: 'From',
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                TextView(
                                                    text:
                                                        data['pick_address'] ??
                                                            '',
                                                    fontSize: 15.5.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.4.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            size: 21.9.sp,
                                          ),
                                          SizedBox(
                                            width: 1.2.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                    text: 'To',
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                TextView(
                                                    text:
                                                        data['drop_address'] ??
                                                            '',
                                                    fontSize: 15.5.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      )
                      .toList()
                ]);
              },
            ))));
  }
}
