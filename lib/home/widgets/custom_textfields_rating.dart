import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTextFieldRating extends StatelessWidget {
  // Future<void> getd() async {
  //   // String api = "$uri/api/users/652c13658f6c95d46e4c2822";
  //   // // Define the base URL and the endpoint
  //   // final url = Uri.parse(api);
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // Make the HTTP GET request and await the response
  //   // final response = await get(url);
  //   String? token =  preferences.getString('token');
  //   Response res = await get(Uri.parse('$uri/api/movies/658596d9cf2a5e978c6902e6/reviews'), headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token',
  //   });
  //   // Check if the response status code is 200 (OK)
  //   if (res.statusCode == 200) {
  //     // Parse the response body as a map of JSON objects
  //     final Map<String, dynamic> data = jsonDecode(res.body);
  //     print(data);
  //   } else {
  //     // Throw an exception if the response status code is not 200
  //     throw Exception(res.statusCode);
  //   }
  // }
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const CustomTextFieldRating(
      {super.key,
      required this.controller,
      required this.hintText,
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
        suffixIcon: GestureDetector(
          onTap: () {
            print('Image tapped!');
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Image.asset(Constants.sendPath, width: 36, height: 36),
          ),
        ),
      ),
      maxLines: maxLines,

    );
  }
}
