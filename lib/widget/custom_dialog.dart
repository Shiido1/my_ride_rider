// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/colors.dart';

void showCustomDialog(BuildContext context,
    {String? title,
    required List<String> items,
    required Function(String value)? onTap}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          items: items,
          onTap: onTap,
        );
      });
}

class CustomDialogBox extends StatelessWidget {
  final String? title;
  final List<String> items;
  var onTap;

  CustomDialogBox(
      {Key? key, this.title, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      margin: EdgeInsets.only(left: 40.w, top: 15.w),
      padding: EdgeInsets.only(left: 8.w, top: 3.w, bottom: 3.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...items.map((item) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      child: Text(
                        item,
                        style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        onTap!(item);
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
