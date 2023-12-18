import 'package:flutter/material.dart';

String uri = 'http://149.28.159.68:3000';

class Constants {
  static const searchPath = 'assets/images/search.png';
  static const backPath = 'assets/images/back.png';
  static const trailerPath = 'assets/images/trailerbutton.png';
  static const bookingPath = 'assets/images/bookingbutton.png';
  static const sendPath = 'assets/images/send.png';

  static const colorTitle = Color(0xffF74346);
  static const backgroundColor = Color(0xff130B2B);

   static Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffFA6900), Color(0xffDA004E)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200, 70.0));
}
