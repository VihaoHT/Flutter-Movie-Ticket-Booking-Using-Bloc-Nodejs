import 'package:flutter/material.dart';
import 'package:movie_booking_app/home/screens/home_screen.dart';
import 'package:movie_booking_app/map/screens/map_screen.dart';
import 'package:movie_booking_app/profile/screens/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIndex = 0;
  final pages = [
    const HomeScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Color(0xffF74346),
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              color:Color(0xff4A4B56),
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.movie,
              color: Color(0xffF74346),
              size: 35,
            )
                : const Icon(
              Icons.movie_outlined,
              color:Color(0xff4A4B56),
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.person,
              color: Color(0xffF74346),
              size: 35,
            )
                : const Icon(
              Icons.person_outline,
              color:Color(0xff4A4B56),
              size: 35,
            ),
          ),

        ],
      ),
    );
  }
}