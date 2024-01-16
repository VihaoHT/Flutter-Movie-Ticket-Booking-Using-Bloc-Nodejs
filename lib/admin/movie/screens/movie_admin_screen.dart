import 'package:flutter/material.dart';

import '../../../core/components/header_admin.dart';

class MovieAdminScreen extends StatelessWidget {
  const MovieAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              HeaderAdmin(title: "Movie screen"),
            ],
          ),
        ),
      ),
    );
  }
}
