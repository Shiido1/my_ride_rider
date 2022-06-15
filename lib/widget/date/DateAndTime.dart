import 'dart:ui';

import 'package:flutter/material.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(radius: 25,),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text('Hi there,',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                        SizedBox(height: 5,),
                        Text('Book your ride',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,

                          ),),
                        SizedBox(height: 30,),
                      ],

                    ),
                    decoration: BoxDecoration(
                      color: Color(0XFF000B49),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 5,),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  )
                ],
              ),


            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon( Icons.arrow_back_ios_rounded)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text('Date/Time', style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          children: [
                            Text('Select date...',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.start,),
                          ],
                        ),
                      ),

                      ),
                    ),


                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Time', style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Select time...',
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.start,),
                            Icon(Icons.access_time_rounded)
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(height: 120,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(

                      color: Color(0XFF000B49),
                    ),
                    child: Center(
                      child: Text('Continue', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ]
      ),


    );
  }
}
