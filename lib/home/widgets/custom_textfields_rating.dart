

import 'package:flutter/material.dart';


class CustomTextFieldRating extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Function(String, double) onSendPressed; // Hàm callbackam số hàm callback
  const CustomTextFieldRating(
      {super.key,
      required this.controller,
      required this.hintText,
        required this.onSendPressed,
        this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffDA004E)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffDA004E)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffDA004E)),
        ),
      ),
      maxLines: maxLines,

    );
  }
}
