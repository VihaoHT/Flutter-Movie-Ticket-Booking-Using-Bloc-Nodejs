

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as GetX;
import 'package:movie_booking_app/auth/screens/login_screen.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/home/screens/home_screen.dart';
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/profile/screens/change_password_screen.dart';
import 'package:movie_booking_app/profile/screens/my_ticket_screen.dart';
import 'package:movie_booking_app/profile/screens/update_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async{
          if(state is LoggedOutState){
            SharedPreferences prefrences = await SharedPreferences.getInstance();
            prefrences.remove("token");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 18),
                alignment: Alignment.topCenter,
                child: const Text(
                  "My Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// check if user doesn't have avatar will be set avatar default
                    (state is AuthSuccess && state.user.avatar != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(27.0),
                            child: Image.network(
                              state.user.avatar!,
                              width: 105,
                              height: 105,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Image.asset(
                            Constants.avatarDefaultPath,
                            width: 105,
                            height: 105,
                          ),
                    Container(
                      width: 150,
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text(
                            'Hi! ${(state as AuthSuccess).user.username}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  GetX.Get.to(()=> const MyTicketScreen(),transition: GetX.Transition.cupertino,duration: const Duration(seconds: 1));
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                child: Ink(
                  decoration: BoxDecoration(
                      color: const Color(0xff2B2B38),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: 288,
                    height: 58,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 27),
                            child: Image.asset(Constants.ticketIconPath)),
                        const Text(
                          'My tickets',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 22),
                            child: Image.asset(Constants.arrowLeftPath)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              ElevatedButton(
                onPressed: () {
                  GetX.Get.to(const UpdateProfileScreen(),transition: GetX.Transition.cupertino,duration: const Duration(seconds: 1));
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                child: Ink(
                  decoration: BoxDecoration(
                        color: const Color(0xff2B2B38),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: 288,
                    height: 58,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 27),
                            child: Image.asset(Constants.editIconPath)),
                        const Text(
                          'Update my profile',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 22),
                            child: Image.asset(Constants.arrowLeftPath)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              ElevatedButton(
                onPressed: () {
                  GetX.Get.to(const ChangePasswordScreen(),transition: GetX.Transition.cupertino,duration: const Duration(seconds: 1));
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                child: Ink(
                  decoration: BoxDecoration(
                      color: const Color(0xff2B2B38),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: 288,
                    height: 58,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 27),
                            child: Image.asset(Constants.settingPath)),
                        const Text(
                          'Change password',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 22),
                            child: Image.asset(Constants.arrowLeftPath)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogOut());
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xffF34C30), Color(0xffDA004E)]),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: 289,
                    height: 60,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 31),
                            child: Image.asset(Constants.logoutPath)),
                        Container(
                          margin: const EdgeInsets.only(left: 65),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
