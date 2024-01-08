import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/constants/constants.dart';

class CustomTextFieldMap extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextFieldMap(
      {super.key,
        required this.controller,
        required this.hintText,
        this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          color: Constants.colorTitle
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFA6900)),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFA6900)), // Đổi màu tại đây
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
      maxLines: maxLines,
    );
  }
}
