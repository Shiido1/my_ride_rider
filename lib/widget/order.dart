import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 200,
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
                            'Driver accepted Ride',
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
                decoration: BoxDecoration(color: Color(0XFF000B49), borderRadius: BorderRadius.circular(30)),
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('Your ride', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(15), vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                ),
                CircleAvatar(
                  radius: 40,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 90,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'ANTHONY JOSHUA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Total No of rides: 51'),
                  Icon(Icons.star),
                  Text('4.0')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOYOTA CAMRY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Color: Blue'),
                  Text('Plate No: Col 1288')
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Routers.pushNamed(context, "/confirm_order");
            },
            child: Container(
              width: 220,
              height: 40,
              decoration: BoxDecoration(color: Color(0XFF000B49)),
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Routers.replaceAllWithName(context, "/home");
            },
            child: Text(
              'Cancel Request',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
