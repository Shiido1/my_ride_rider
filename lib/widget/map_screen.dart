import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/utils/users_dialog.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../constants/session_manager.dart';
import 'custom_waiting_widget.dart';

class MapScreen extends StatefulWidget {
  final String fname;
  final String lname;
  final String pickLocation;
  final String dropLocation;
  const MapScreen({
    Key? key,
    required this.fname,
    required this.lname,
    required this.pickLocation,
    required this.dropLocation,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => UserDialog.showSnackBar(
        context,
        'You\'ll receive a pop up dialog notification when driver arrives pickup location, Please don\'t leave this screen'));
    arrivalStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/mapimgg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 5.w, top: 5.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 28,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
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
                )),
            Padding(
                padding: EdgeInsets.only(left: 5.w, top: 10.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextView(
                    text: 'Pick up',
                    fontSize: 19.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                )),
            Positioned(
              top: 100,
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.w),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                        Container(
                          height: 60,
                          width: 1,
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 1.h),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          readOnly: true,
                          controller:
                              TextEditingController(text: widget.pickLocation),
                          decoration: Constants.defaultDecoration.copyWith(
                            labelText: "FROM",
                            labelStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller:
                              TextEditingController(text: widget.dropLocation),
                          decoration: Constants.defaultDecoration.copyWith(
                            labelText: "TO",
                            labelStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 1.w),
                  const Center(child: Icon(Icons.repeat))
                ]),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 7.w),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black,
                  ),
                ),
                child: TextView(
                    text: 'Change Location',
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * .36,
                decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25))),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: .3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 1.5.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.2.w),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.phone,
                            color: AppColors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1.5.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.8.w, vertical: 1.2.w),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: Icon(
                            Icons.message,
                            color: AppColors.primary,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1.5.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 2.6.w),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: TextView(
                              text: 'Driving enroute pick up',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1.5.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.8.w, vertical: 1.5.w),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.white,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 2.5.w),
                height: MediaQuery.of(context).size.height * .29,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32))),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 5,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextView(
                                text: "${widget.fname} ${widget.lname}",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TextView(
                                text: vehicleName ?? '',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TextView(
                                text: "$vehicleNumber",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TextView(
                                text: "Total No of Rides: 51",
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextView(
                                  text: '*',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.yellow),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 3.w, left: 1.w),
                                child: TextView(
                                    text: '4.0',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.grey1,
                        thickness: 2.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            text: 'Share ride location',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGreen10,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Icon(
                            Icons.share,
                            color: AppColors.textGreen10,
                            size: 21.sp,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final _streamUser = databaseReference.child("users_request");
  // DatabaseReference userDBReference =
  //     FirebaseDatabase.instance.ref('users_request');

  Future arrivalStatus() async {
    Map<String, dynamic>? usersRes;
    StreamSubscription<DatabaseEvent>? _counterSubscription;
    // DatabaseEvent dataEvent = await userDBReference
    //     .child(SessionManager.instance.usersData["id"])
    //     .once();

    _streamUser
        .child('${SessionManager.instance.usersData["id"]}')
        .onChildChanged
        .listen((event) {
      usersRes = Map<String, dynamic>.from(event.snapshot.value as Map);
      print(usersRes!['arrive_pick_up']);
      print(event.snapshot.value.toString());
      if (event.snapshot.value.toString() == 'Arrived') {
        // Container(
        //   height: 100,
        //   width: 100,
        //   color: AppColors.white,
        //   child: Column(
        //     children: [
        //       TextView(text: pickUpLocationAdd ?? ''),
        //       TextView(text: vehicleName ?? ''),
        //       TextView(text: vehicleColor ?? ''),
        //       TextView(text: vehicleNumber ?? ''),
        //     ],
        //   ),
        // );
        showDialog(
            context: context,
            builder: (BuildContext cntxt) {
              return const CustomRideDialog();
            });
      }
    });
  }
}
