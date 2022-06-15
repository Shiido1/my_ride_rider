import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Booked extends StatelessWidget {
  const Booked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 220,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
            child: Column(
              children: [
                Text('Hello Lona',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                SizedBox(height: 10,),
                Text('Your trip has been successfully booked.\n'
                    'You will get a notification via email and text a\n day your trip.\n'
                    'Thank you for choosing My ride.', textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),

          Divider(thickness: 1,),
          SizedBox(height: 120,),
          Divider(thickness: 1,),
          SizedBox(height: 30,),
          InkWell(
            child: Container(
              width: 220,
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0XFF000B49)
              ),
              child: Center(
                child: Text('Home', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16

                ),),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
