import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';
import 'package:movie_booking_app/core/components/header_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/constants.dart';

class StatisticsAdminScreen extends StatefulWidget {
  const StatisticsAdminScreen({super.key});

  @override
  State<StatisticsAdminScreen> createState() => _StatisticsAdminScreenState();
}

class _StatisticsAdminScreenState extends State<StatisticsAdminScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final response = await get(
        Uri.parse("$uri/api/tickets/thong-ke/yearly?year=2024"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      //print(json.decode(response.body)['data']);
      return json.decode(response.body)['data'];
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Column(
            children: [
              const HeaderAdmin(title: "Statistics Manager"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColorSuggest(
                        color: Colors.blue,
                        title: "January",
                      ),
                      ColorSuggest(
                        color: Colors.red,
                        title: "February",
                      ),
                      ColorSuggest(
                        color: Colors.yellow,
                        title: "March",
                      ),
                      ColorSuggest(
                        color: Colors.green,
                        title: "April",
                      ),
                      ColorSuggest(
                        color: Colors.cyanAccent,
                        title: "May",
                      ),
                      ColorSuggest(
                        color: Colors.pinkAccent,
                        title: "June",
                      ),
                      ColorSuggest(
                        color: Colors.purple,
                        title: "July",
                      ),
                      ColorSuggest(
                        color: Colors.teal,
                        title: "August",
                      ),
                      ColorSuggest(
                        color: Colors.grey,
                        title: "September",
                      ),
                      ColorSuggest(
                        color: Colors.blueGrey,
                        title: "October",
                      ),
                      ColorSuggest(
                        color: Colors.amber,
                        title: "November",
                      ),
                      ColorSuggest(
                        color: Colors.orange,
                        title: "December",
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        "Monthly Earnings All Sold Tickets",
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 29,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 700,
                        height: 700,
                        child: FutureBuilder(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator()); // Display loading for data waiting
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                //price format
                                String formattedMonth1 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[0]);
                                String formattedMonth2 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[1]);
                                String formattedMonth3 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[2]);
                                String formattedMonth4 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[3]);
                                String formattedMonth5 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[4]);
                                String formattedMonth6 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[5]);
                                String formattedMonth7 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[6]);
                                String formattedMonth8 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[7]);
                                String formattedMonth9 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[8]);
                                String formattedMonth10 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[9]);
                                String formattedMonth11 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[10]);
                                String formattedMonth12 = NumberFormat.currency(
                                        locale: 'vi_VN', symbol: 'VND')
                                    .format(snapshot.data[11]);
                                return PieChart(
                                    swapAnimationCurve: Curves.easeInOutQuint,
                                    swapAnimationDuration:
                                        const Duration(milliseconds: 750),
                                    PieChartData(sections: [
                                      PieChartSectionData(
                                        value: snapshot.data[0].toDouble(),
                                        title: formattedMonth1,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.blue,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[1].toDouble(),
                                        title: formattedMonth2,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.red,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[2].toDouble(),
                                        title: formattedMonth3,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.yellow,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[3].toDouble(),
                                        title: formattedMonth4,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.green,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[4].toDouble(),
                                        title: formattedMonth5,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.cyanAccent,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[5].toDouble(),
                                        title: formattedMonth6,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.pinkAccent,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[6].toDouble(),
                                        title: formattedMonth7,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.purple,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[7].toDouble(),
                                        title: formattedMonth8,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.teal,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[8].toDouble(),
                                        title: formattedMonth9,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.grey,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[9].toDouble(),
                                        title: formattedMonth10,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.blueGrey,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[10].toDouble(),
                                        title: formattedMonth11,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.amber,
                                      ),
                                      PieChartSectionData(
                                        value: snapshot.data[11].toDouble(),
                                        title: formattedMonth12,
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        color: Colors.orange,
                                      ),
                                    ]));
                              }
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ColorSuggest extends StatelessWidget {
  final Color color;
  final String title;

  const ColorSuggest({
    super.key,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
