import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
         
        },
        builder: (context, state) {
          return Text((state as AuthSuccess).user.token
            ,
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
