import 'package:flutter/material.dart';
import 'package:movie_booking_app/auth/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff130B2B),
        useMaterial3: true,
      ),
      home:  const LoginScreen(),
    );
  }
}
