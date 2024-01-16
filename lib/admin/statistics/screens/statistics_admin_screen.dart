import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/core/components/header_admin.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../../core/constants/constants.dart';

class StatisticsAdminScreen extends StatefulWidget {
  const StatisticsAdminScreen({super.key});

  @override
  State<StatisticsAdminScreen> createState() => _StatisticsAdminScreenState();
}

class _StatisticsAdminScreenState extends State<StatisticsAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              HeaderAdmin(title: "Statistics screen"),
            ],
          ),
        ),
      ),
    );
  }
}
