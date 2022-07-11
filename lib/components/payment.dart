// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 700,
            width: 380,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 80, 10, 80),
              child: Column(
                children: [
                  Icon(
                    Icons.done_rounded,
                    color: Colors.green,
                    size: 80.sp,
                  ),
                  Text(
                    'Payment Successful',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You have successfully paid for your ride. Thank you for your patronage',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Routers.replaceAllWithName(context, "/home");
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
                      child: Container(
                        width: 380,
                        height: 50,
                        decoration: BoxDecoration(color: Color(0XFF000B49)),
                        child: Center(
                          child: Text(
                            'Home',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
