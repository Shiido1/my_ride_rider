import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/components/destination.dart';
import 'package:my_ride/components/payment.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/components/ride_arrival.dart';
import 'package:my_ride/components/reason.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class TripStarted extends StatefulWidget {
  const TripStarted({Key? key}) : super(key: key);

  @override
  State<TripStarted> createState() => _TripStartedState();
}

class _TripStartedState extends State<TripStarted> {
  @override
  void initState() {
    super.initState();

    delayAndMoveToNextPage(context);
    delayPaymentSuccess(context);
    delayMoveToNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: Adaptive.h(60),
          ),
          Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 40,
                        child: Icon(
                          Icons.phone_outlined,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 40,
                        color: Colors.white,
                        child: Icon(
                          Icons.message,
                          color: Color(0XFF000B49),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 250,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Enroute drop off',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          height: 30,
                          width: 40,
                          child: Icon(Icons.location_on_rounded, size: 20, color: Colors.redAccent),
                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white))),
                    ],
                  ),
                ),
                height: 100,
                decoration: BoxDecoration(color: const Color(0XFF000B49), borderRadius: BorderRadius.circular(30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 3,
                          width: 60,
                          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    ],
                  ),
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Adaptive.w(30)),
              SizedBox(
                width: Adaptive.w(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ANTHONY JOSHUA',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('TOYOTA CAMRY'),
                    Text('CGL 1288'),
                    Text('Total No of rides: 51')
                  ],
                ),
              ),
              SizedBox(
                width: Adaptive.w(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[600],
                    ),
                    Text('4.0')
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              // delayAndMoveToNextPage(context);
              // delayPaymentSuccess(context);
              // openUrl("https://www.google.com/maps/dir/Current+Location/44.277549,-78.338084");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Share ride location',
                  style: TextStyle(color: AppColors.secondary, fontSize: Adaptive.sp(17)),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.share,
                  color: AppColors.secondary,
                  size: Adaptive.sp(22),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void openUrl(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void delayAndMoveToNextPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      showDialog(
          context: context,
          // barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                child: const Destination(),
                width: Adaptive.w(80),
                height: 400,
              ),
            );
          });
    });
  }

  void delayPaymentSuccess(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      Routers.pop(context);
      showDialog(
          context: context,
          // barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                child: const PaymentDialog(),
                width: Adaptive.w(80),
                height: 450,
              ),
            );
          });
    });
  }

  void delayMoveToNextPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 8), () {
      Routers.pop(context);
      Routers.pushNamed(context, "/rate_driver");
    });
  }
}
