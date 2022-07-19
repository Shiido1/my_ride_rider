// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingButton extends StatefulWidget {
  String label;
  Function() onPressed;
  bool? isLoading;
  bool? disabled;
  LoadingButton(
      {Key? key,
      required this.isLoading,
      this.disabled,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (widget.isLoading == true) ? () {} : widget.onPressed,
      child: (widget.isLoading == true)
          ? const SpinKitWave(
              color: Colors.white,
              size: 25.0,
            )
          : TextView(
              text: widget.label,
              fontSize: 18.sp,
            ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
        backgroundColor: MaterialStateProperty.all(
            AppColors.primary.disable(widget.disabled == true)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
      ),
    );
  }
}
