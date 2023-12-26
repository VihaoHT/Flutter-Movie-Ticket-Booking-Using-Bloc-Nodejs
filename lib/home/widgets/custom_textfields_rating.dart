import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    double myRating = 3.5; // Khai báo myRating ở đây
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
