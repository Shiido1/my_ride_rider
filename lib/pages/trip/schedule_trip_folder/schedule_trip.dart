import 'package:flutter/material.dart';
import 'package:my_ride/pages/trip/schedule_trip_folder/tabs_folder/tab1_screen.dart';
import 'package:my_ride/pages/trip/schedule_trip_folder/tabs_folder/tab2_screen.dart';
import 'package:my_ride/pages/trip/schedule_trip_folder/tabs_folder/tab3_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/colors.dart';
import '../../../widget/text_widget.dart';

class ViewScheduleRide extends StatefulWidget {
  const ViewScheduleRide({Key? key}) : super(key: key);

  @override
  _ViewScheduleRideState createState() => _ViewScheduleRideState();
}

class _ViewScheduleRideState extends State<ViewScheduleRide> {
  // void closeSchedule() {
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 5.w, left: 2.w),
            child: TextView(
              text: 'Your Schedule',
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              maxLines: 1,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                size: 21.5.sp,
              ),
              color: AppColors.black,
              onPressed: () {
                // closeSchedule();
              },
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          backgroundColor: AppColors.white,
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.black,
            labelColor: AppColors.primary,
            tabs: [
              Tab(
                // text: 'Upcoming',
                child: TextView(
                  text: 'Upcoming',
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ),
              Tab(
                child: TextView(
                  text: 'Completed',
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ),
              Tab(
                child: TextView(
                  text: 'Cancel',
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
        body:  const TabBarView(
          children: [Tab1(), Tab2(), Tab3()],
        ),
      ),
    );
  }
}
