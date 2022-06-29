import 'package:flutter/material.dart';
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
