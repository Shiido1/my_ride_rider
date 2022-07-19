// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/colors.dart';
import 'text_widget.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
}

contentBox(context) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        ]),
    child: TextView(
      text:'Please switch on or enable this app to have access to your location to be able to use this app',
      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
    ),
  );
}

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
