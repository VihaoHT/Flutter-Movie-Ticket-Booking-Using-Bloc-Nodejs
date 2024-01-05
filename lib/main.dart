import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';
import 'package:movie_booking_app/auth/screens/login_screen.dart';
import 'package:movie_booking_app/auth/screens/signup_screen.dart';
import 'package:movie_booking_app/core/respository/movie_respository.dart';
import 'package:movie_booking_app/core/respository/top5_respository.dart';
import 'package:movie_booking_app/home/movie_bloc/movie_bloc.dart';
import 'package:movie_booking_app/home/screens/home_screen.dart';
import 'package:movie_booking_app/home/search_bloc/search_bloc.dart';
import 'package:movie_booking_app/home/top5_bloc/top5_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(MovieRespository())..add(LoadMovieEvent())),
      BlocProvider<Top5Bloc>(
          create: (_) => Top5Bloc(Top5Respository())..add(LoadTop5Event())),
      BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(MovieRespository())..add(LoadSearchEvent())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff130B2B),
          useMaterial3: true,
        ),
        home: const LoginScreen());
  }
}
