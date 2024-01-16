import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserAdminScreen extends StatelessWidget {
  const UserAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Text("User screen",style: TextStyle(color: Colors.white
      ),),
    ));
  }
}