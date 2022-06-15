import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String labelText;
  final controller;
  final bool obscure;
  final TextInputType textType;
  const TextSection({Key? key, required this.labelText, required this.obscure, required this.textType, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textAlign: TextAlign.start,
        obscureText: obscure,
        keyboardType: textType,
        controller: controller,
        style: TextStyle(

          color: Colors.black87,

        ),
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),




        ),
      ),
    );
  }
}
