import 'package:flutter/material.dart';

class CustomTextFieldAdd extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
final bool readOnly;
  const CustomTextFieldAdd({
    super.key,
    required this.controller,
    required this.hintText, required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 24, right: 24),
      color: const Color(0xFF212332),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Enter your $hintText";
          }
          return null;
        },
      ),
    );
  }
}
