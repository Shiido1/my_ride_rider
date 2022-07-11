import 'package:flutter/material.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.w),
          child: TextView(
            text: 'Select Ride',
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
