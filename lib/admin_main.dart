import 'package:flutter/material.dart';
import 'package:movie_booking_app/admin/actors/screens/actor_admin_screen.dart';
import 'package:movie_booking_app/admin/cinema/screens/cinema_admin_screen.dart';
import 'package:movie_booking_app/admin/movie/screens/movie_admin_screen.dart';
import 'package:movie_booking_app/admin/showtime/screens/showtime_admin_screen.dart';
import 'package:movie_booking_app/admin/statistics/screens/statistics_admin_screen.dart';
import 'package:movie_booking_app/admin/user/screens/update_admin_profile.dart';
import 'package:movie_booking_app/admin/user/screens/user_admin_screen.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/profile/screens/update_profile_screen.dart';

import 'admin/room/screens/room_admin_screen.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  String selectedDrawerItem = "Statistics"; // Mục được chọn mặc định
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.bgColorAdmin,
        body: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                DrawerHeader(child: Image.asset(Constants.logoPath)),
                DrawerListTile(
                  title: "Statistics",
                  imageSrc: Constants.statisticPath,
                  press: () {
                    // Cập nhật trạng thái khi mục Movie được chọn
                    setState(() {
                      selectedDrawerItem = "Statistics";
                    });
                  },
                  isSelected: selectedDrawerItem == "Statistics",
                ),
                DrawerListTile(
                  title: "Movie",
                  imageSrc: Constants.moviePath,
                  press: () {
                    // Cập nhật trạng thái khi mục Movie được chọn
                    setState(() {
                      selectedDrawerItem = "Movie";
                    });
                  },
                  isSelected: selectedDrawerItem == "Movie",
                ),
                DrawerListTile(
                  title: "User",
                  imageSrc: Constants.profilePath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "User";
                    });
                  },
                  isSelected: selectedDrawerItem == "User",
                ),
                DrawerListTile(
                  title: "Cinema",
                  imageSrc: Constants.cinemaPath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "Cinema";
                    });
                  },
                  isSelected: selectedDrawerItem == "Cinema",
                ),
                DrawerListTile(
                  title: "Showtime",
                  imageSrc: Constants.showtimePath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "Showtime";
                    });
                  },
                  isSelected: selectedDrawerItem == "Showtime",
                ),
                DrawerListTile(
                  title: "Room",
                  imageSrc: Constants.roomPath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "Room";
                    });
                  },
                  isSelected: selectedDrawerItem == "Room",
                ),
                DrawerListTile(
                  title: "Actor",
                  imageSrc: Constants.actorPath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "Actor";
                    });
                  },
                  isSelected: selectedDrawerItem == "Actor",
                ),
                DrawerListTile(
                  title: "Settings",
                  imageSrc: Constants.settingPath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "Settings";
                    });
                  },
                  isSelected: selectedDrawerItem == "Settings",
                ),
              ],
            )),
            Expanded(
              flex: 5,
              child: Container(
                color: Constants.bgColorAdmin,
                child: _buildSelectedContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContent() {
    // Dựa vào trạng thái để hiển thị nội dung tương ứng
    switch (selectedDrawerItem) {
      case "Statistics":
        return const StatisticsAdminScreen();
      case "Movie":
        return const MovieAdminScreen();
      case "User":
        return const UserAdminScreen();
      case "Cinema":
        return const CinemaAdminScreen();
      case "Showtime":
        return const ShowtimeAdminScreen();
      case "Room":
        return const RoomAdminScreen();
      case "Actor":
        return const ActorAdminScreen();
      case "Settings":
        return const UpdateAdminProfile();
      default:
        return Container();
    }
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, imageSrc;
  final bool isSelected;
  final VoidCallback press;

  const DrawerListTile({
    super.key,
    required this.title,
    required this.press,
    required this.imageSrc,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Image.asset(
        imageSrc,
        color: Colors.white54,
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
