import 'package:flutter/material.dart';

String uri = 'http://192.168.2.6:3000';

class Constants {
  static const searchPath = 'assets/images/search.png';
  static const backPath = 'assets/images/back.png';
  static const trailerPath = 'assets/images/trailerbutton.png';
  static const bookingPath = 'assets/images/bookingbutton.png';
  static const sendPath = 'assets/images/send.png';
  static const back2Path = 'assets/images/back2.png';
  static const locationPath = 'assets/images/location.png';
  static const linePath = 'assets/images/line.png';
   static const line2Path = 'assets/images/line2.png';

  static const colorTitle = Color(0xffF74346);
  static const backgroundColor = Color(0xff130B2B);

   static Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffFA6900), Color(0xffDA004E)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200, 70.0));
}
