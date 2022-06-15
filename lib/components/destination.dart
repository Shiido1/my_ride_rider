import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Destination extends StatelessWidget {
  const Destination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Ride has arrived Destination',
                        style: TextStyle(
                          fontSize: Adaptive.sp(17),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Welcome to Hartsfield Jackson',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'International Airport',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0XFF000B49),
                  ),
                ),
              )
            ],
          ),
        Center(child: Image.asset("assets/images/car3.jpeg")),
        ],
      )),
    );
  }
}
