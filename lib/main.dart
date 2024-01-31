import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_booking_app/admin/cinema/cinema_bloc/cinema_bloc.dart';
import 'package:movie_booking_app/admin/room/room_bloc/room_bloc.dart';
import 'package:movie_booking_app/admin/showtime/showtime_bloc/showtime_bloc.dart';
import 'package:movie_booking_app/admin/user/users_bloc/users_bloc.dart';
import 'package:movie_booking_app/admin_main.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';
import 'package:movie_booking_app/auth/screens/login_screen.dart';
import 'package:movie_booking_app/bottom_navigation.dart';
import 'package:movie_booking_app/core/respository/cinema_repository.dart';
import 'package:movie_booking_app/core/respository/movie_respository.dart';
import 'package:movie_booking_app/core/respository/room_repository.dart';
import 'package:movie_booking_app/core/respository/showtime_repository.dart';
import 'package:movie_booking_app/core/respository/top5_respository.dart';
import 'package:movie_booking_app/core/respository/users_respository.dart';
import 'package:movie_booking_app/home/movie_bloc/movie_bloc.dart';
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
          create: (_) =>
              SearchBloc(MovieRespository())..add(const LoadSearchEvent())),
      BlocProvider<UsersBloc>(
          create: (_) =>
          UsersBloc(UserRepository())..add( const SearchLoadUserEvent(name: ""))),
      BlocProvider<CinemaBloc>(
          create: (_) =>
          CinemaBloc(CinemaRepository())..add(const LoadSearchCinemaEvent(name: ""))),
      BlocProvider<ShowtimeBloc>(
          create: (_) =>
          ShowtimeBloc(ShowtimeRepository())..add(const LoadSearchShowtimeEvent(title: ""))),
      BlocProvider<RoomBloc>(
          create: (_) =>
          RoomBloc(RoomRepository())..add( const LoadSearchRoomEvent(id: ""))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff130B2B),

          useMaterial3: true,
        ),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              if(state.user.role == "user") {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigation(),
                  ),
                      (route) => false,
                );
              }
              else{
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminMain(),
                  ),
                      (route) => false,
                );
              }
            }
            if (state is AuthInitial) {
               const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginScreen();
          },
        ));
  }
}
