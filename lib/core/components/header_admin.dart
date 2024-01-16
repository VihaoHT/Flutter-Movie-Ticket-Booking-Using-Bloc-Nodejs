import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';

import '../../auth/screens/login_screen.dart';
import '../constants/constants.dart';

class HeaderAdmin extends StatefulWidget {
  final String title;
  const HeaderAdmin({super.key, required this.title});

  @override
  State<HeaderAdmin> createState() => _HeaderAdminState();
}

class _HeaderAdminState extends State<HeaderAdmin> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
         widget.title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF212332),
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                const Text("failed to load data");
              }
              // this is for Logout event
              if(state is AuthSuccess){
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
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListTile(
                leading:  (state is AuthSuccess && state.user.avatar != null)
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(27.0),
                  child: Image.network(
                    state.user.avatar!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                )
                    : Image.asset(
                  Constants.avatarDefaultPath,
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  (state as AuthSuccess).user.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing:
                PopupMenuButton(
                  icon: const Icon(Icons.arrow_drop_down,color: Colors.white54),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "logout",
                        child: Text("Logout"),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    // Xử lý khi một tùy chọn được chọn từ PopupMenu
                    if (value == "logout") {
                      context.read<AuthBloc>().add(LogOut());
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
