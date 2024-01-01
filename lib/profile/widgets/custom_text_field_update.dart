import 'package:flutter/material.dart';

class CustomTextFieldUpdate extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String label;
  final bool readOnly;

  const CustomTextFieldUpdate(
      {super.key,
        required this.controller,
        required this.hintText,
        this.maxLines = 1, required this.label, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5,left: 24,right: 24),
      child: TextFormField(

        style: const TextStyle(
            color: Colors.white
        ),
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white, // Màu sắc của label text
            fontWeight: FontWeight.bold   // Kích thước của label text
          ),
          // label:  Text(label,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
