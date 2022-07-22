import 'package:flutter/material.dart';
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
                height: 4.h,
              ),
              TextView(
                text:" Your request for a ride was kindly rejected by the driver, please try requesting for another ride\nThanks",
                fontSize: 16.8.sp, fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
}
