import 'package:flutter/material.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/colors.dart';
import '../models/global_model.dart';

class CustomScheduleRideDialog extends StatefulWidget {
  final String? pickAddress;
  final String? dropAddress;
  final String? tripTime;
  const CustomScheduleRideDialog(
      {Key? key, this.pickAddress, this.dropAddress, this.tripTime})
      : super(key: key);

  @override
  State<CustomScheduleRideDialog> createState() =>
      _CustomScheduleRideDialogState();
}

class _CustomScheduleRideDialogState extends State<CustomScheduleRideDialog> {
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
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 7.w),
        decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  height: 50,
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "RIDE REQUEST",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              TextView(
                text:
                    "Your scheduled ride from ${widget.pickAddress} to ${widget.dropAddress} is 30 minutes away ${widget.tripTime}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1.4.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Routers.pushNamed(context, "/view_schedule_ride");
                  cron.close();
                  Routers.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.green,
                ),
                child: TextView(
                  text: "OK",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      );
}
