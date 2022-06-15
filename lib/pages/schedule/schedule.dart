import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<String> schedulePlans = ["Instant", "Weekly", "Bi-weekly", "One month"];

  String defaultPlan = "Weekly";

  List<Widget> location = [
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
    Text("Ocean center, Gudu"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          radius: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Hi there,',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Book your ride',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0XFF000B49),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Routers.pop(context);
                  })
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 10, right: 10.w),
          child: Row(
            children: [
              Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: schedulePlans.map((item) => pillet(item)).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InkWell(
            onTap: _showModalBottomSheet,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
                    child: Row(
                      children: [
                        Container(
                          child: FaIcon(
                            FontAwesomeIcons.person,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Enter pickup location',
                          style: TextStyle(color: Colors.black26, fontSize: 17.sp),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InkWell(
            onTap: _showModalBottomSheet,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Icon(
                            Icons.location_on_rounded,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Enter Destination location',
                          style: TextStyle(color: Colors.black26, fontSize: 17.sp),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Add place'),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add,
                color: Colors.green,
                size: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'Recent places',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 15,
                    ),
                  ),
                  Positioned(
                      left: 2.9,
                      top: 1.5,
                      child: Icon(
                        Icons.house_outlined,
                        color: Colors.black26,
                      )),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'No 33, Boulevard Street',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 15,
                    ),
                  ),
                  Positioned(
                      left: 2.9,
                      top: 1.5,
                      child: Icon(
                        Icons.house_outlined,
                        color: Colors.black26,
                      )),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'No 33, Boulevard Street',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'View Schedule',
                style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 180,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0XFF000B49),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget pillet(String label) {
    if (defaultPlan == label) {
      return InkWell(
        onTap: () {
          setState(() {
            defaultPlan = label;
          });
        },
        child: Container(
          height: 50,
          width: 160,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            color: AppColors.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: () {
        setState(() {
          defaultPlan = label;
        });
      },
      child: Container(
        height: 50,
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 17.sp, color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      builder: (context) {
        return Container(
          height: Adaptive.h(100) - 50,
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Container(
                height: 90,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: Constants.defaultDecoration.copyWith(
                            labelText: "",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ]),
              ),
              SizedBox(
                height: Adaptive.h(100) - 300,
                child: ListView.separated(
                  separatorBuilder: (context, i) {
                    return const Divider();
                  },
                  itemCount: location.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: location[i],
                      onTap: () {
                        //Routers.pushNamed(context, "/select_ride");
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

}
