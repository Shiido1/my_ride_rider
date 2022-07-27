import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final Color? color;
  final double fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final double? wordSpacing;
  final double? letterSpacing;

  const TextView(
      {Key? key,
      required this.text,
      this.textStyle,
      this.textOverflow = TextOverflow.clip,
      this.textAlign = TextAlign.left,
      this.color,
      this.onTap,
      this.fontSize = 14.0,
      this.letterSpacing = -0.33,
      this.height,
      this.maxLines,
      this.wordSpacing,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color
        ),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}