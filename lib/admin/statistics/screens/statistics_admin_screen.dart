import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,top:50,right: 16),
          child: Row(
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
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 700,
                    height: 700,
                    child: PieChart(
                        swapAnimationCurve: Curves.easeInOutQuint,
                        swapAnimationDuration:
                            const Duration(milliseconds: 750),
                        PieChartData(sections: [
                          PieChartSectionData(
                            value: 20,
                            color: Colors.blue,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.red,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.yellow,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.green,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.cyanAccent,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.pinkAccent,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.purple,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.teal,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.grey,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.blueGrey,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.amber,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.orange,
                          ),
                        ])),
                  )
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
