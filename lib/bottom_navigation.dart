import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).primaryColor,
          activeColor: const Color(0xffF74346),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0 :
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: HomeScreen());
              },
            );
          case 1 :
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: MapScreen());
              },
            );
          case 2 :
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: ProfileScreen());
              },
            );
        }
        return Container();
      },
    );
  }
}