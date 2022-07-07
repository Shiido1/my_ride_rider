import 'package:flutter/material.dart';
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
          padding: EdgeInsets.all(4.w),
          child: Text(
            'Select Ride',
            style: TextStyle(color: Colors.white, fontSize: 15.5.sp),
          ),
        )
      ],
    );
  }
}
