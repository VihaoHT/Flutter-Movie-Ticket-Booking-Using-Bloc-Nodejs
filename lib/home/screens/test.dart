import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/screens/login_screen.dart';
import '../../core/constants/constants.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthSuccess){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                    (route) => false,
              );
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return  ElevatedButton(
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
            );
          },
        ),
      ),
    );
  }
}
