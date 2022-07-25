import 'package:flutter/material.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors.dart';

class CustomDialogForRejection extends StatelessWidget {
  const CustomDialogForRejection({Key? key}) : super(key: key);

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
                height: 2.h,
              ),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 38,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              TextView(
                text:
                    "Your request for a ride was kindly rejected by the driver, please try requesting for another ride\nThanks",
                fontSize: 16.2.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.5.h,
              ),
              InkWell(
                onTap: () => Routers.pop(context),
                child: Container(
                  width: 16.5.w,
                  height: 3.7.h,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.primary),
                  child: Center(
                    child: TextView(
                      text: 'OK',
                      color: AppColors.white,
                      fontSize: 16.5.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      );
}
