import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
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
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: const Color(0xff130B2B),
        animationCurve: Curves.easeInOutExpo,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          pageIndex == 0
              ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
            children: [
                LottieBuilder.asset(
                  Constants.homeAnimation,
                  width: 30,
                  height: 30,
                ),
                const Text("Home",style: TextStyle(color: Constants.colorTitle,fontSize: 14,fontWeight: FontWeight.bold),),
            ],
          ),
              )
              : const Icon(
                  Icons.home_outlined,
                  color: Color(0xff4A4B56),
                  size: 35,
                ),
          pageIndex == 1
              ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    children: [
                      LottieBuilder.asset(
                        Constants.mapAnimation,
                        width: 30,
                        height: 30,
                      ),
                      const Text(
                        "Map",
                        style: TextStyle(
                            color: Constants.colorTitle,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              )
              : const Icon(
                  Icons.map_outlined,
                  color: Color(0xff4A4B56),
                  size: 35,
                ),
          pageIndex == 2
              ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    children: [
                      LottieBuilder.asset(
                        Constants.profileAnimation,
                        width: 30,
                        height: 30,
                      ),
                      const Text(
                        "Profile",
                        style: TextStyle(
                            color: Constants.colorTitle,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              )
              : const Icon(
                  Icons.person_outline,
                  color: Color(0xff4A4B56),
                  size: 35,
                ),
        ],
        letIndexChange: (index) => true,
      ),
      body: _pages[pageIndex],
    );
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];
}
