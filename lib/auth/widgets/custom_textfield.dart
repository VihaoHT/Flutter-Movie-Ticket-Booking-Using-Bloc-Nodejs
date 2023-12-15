import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5,left: 24,right: 24),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Enter your $hintText";
          }
          return null;
        },
        maxLines: maxLines,
      ),
    );
  }
}
