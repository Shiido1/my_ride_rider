import 'package:flutter/material.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/colors.dart';
import '../utils/router.dart';

class CustomRideDialog extends StatelessWidget {
  const CustomRideDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      backgroundColor: AppColors.transparent,
      child: _buildContext(context),
    );
  }

  _buildContext(
    BuildContext context,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
        decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Connecting to Ride",
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5.h,
              ),
              Icon(
                Icons.phone_iphone,
                size: 50.sp,
                color: AppColors.primary,
              ),
              SizedBox(
                height: 3.4.h,
              ),
              Text(
                "Please wait...",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 3.4.h,
              ),
              InkWell(
                onTap: () => Routers.replaceAllWithName(context, "/home"),
                child: Text(
                  "Cancel Request",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
}

class ArrivalCustomRideDialog extends StatelessWidget {
  const ArrivalCustomRideDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      backgroundColor: AppColors.transparent,
      child: _buildContext(context),
    );
  }

  _buildContext(
    BuildContext context,
  ) =>
      Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 7,
                    child: Container(
                      color: AppColors.primary,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: .9.h,
                            ),
                            TextView(
                              text: "Your Ride has arrived Pick up",
                              fontSize: 16.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextView(
                              text: pickUpLocationAdd!,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextView(
                    text: "Ride Details:",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  TextView(
                    text: vehicleName!,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: "Color: ",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      TextView(
                        text: vehicleColor!,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: "Plate No: ",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      TextView(
                        text: vehicleNumber!,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 3.w),
                    width: 50.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                        'assets/images/car.png',
                      )),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: TextView(
                      text: "Note:",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                    color: AppColors.grey2,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: "Don\'t keep your driver waiting!",
                          fontSize: 14.5.sp,
                          color: AppColors.red,
                        ),
                        TextView(
                          text:
                              "He can cancel after 5 mins and you would be charged \$5",
                          fontSize: 14.5.sp,
                          color: AppColors.red,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                    color: AppColors.grey2,
                    width: MediaQuery.of(context).size.width,
                    child: TextView(
                      text:
                          "If you choose to cancel trip after the driver has arrived destination,you would be charged \$5",
                      fontSize: 14.5.sp,
                      color: AppColors.red,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.5.w, vertical: 2.8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColors.primary,
                        ),
                        child: TextView(
                          text: "OK",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Routers.replaceAllWithName(context, "/home"),
                      child: Text(
                        "Cancel Request",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class DestinationCustomRideDialog extends StatelessWidget {
  const DestinationCustomRideDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      backgroundColor: AppColors.transparent,
      child: _buildContext(context),
    );
  }

  _buildContext(
    BuildContext context,
  ) =>
      Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 7,
                    child: Container(
                      color: AppColors.primary,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            TextView(
                              text: "Your Ride has arrived Destination",
                              fontSize: 16.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: TextView(
                                text: ' Welcome to $dropLocationAdd!',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 3.w),
                    width: 50.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                        'assets/images/car.png',
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class SuccessPaymentCustomRideDialog extends StatelessWidget {
  const SuccessPaymentCustomRideDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      backgroundColor: AppColors.transparent,
      child: _buildContext(context),
    );
  }

  _buildContext(
    BuildContext context,
  ) =>
      Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: AppColors.textGreen10,
                    size: 39.sp,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextView(
                    text: "PAYMENT SUCCESSFUL",
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 1.9.h,
                  ),
                  TextView(
                    text:
                        "You have successfully paid for your ride \nThank you for your patronage",
                    fontSize: 15.sp,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 2.9.h,
                  ),
                  InkWell(
                    onTap: () => Routers.pushNamed(context, '/ratings'),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 5.h,
                        // width: 33.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.5.w, vertical: 2.8.w),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                        ),
                        child: TextView(
                          text: "Home",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
