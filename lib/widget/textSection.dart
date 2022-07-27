// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String labelText;
  final controller;
  final bool obscure;
  final TextInputType textType;
  const TextSection({Key? key, required this.labelText, required this.obscure, required this.textType, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      obscureText: obscure,
      keyboardType: textType,
      controller: controller,
      style: const TextStyle(
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),




      ),
    );
  }
}
