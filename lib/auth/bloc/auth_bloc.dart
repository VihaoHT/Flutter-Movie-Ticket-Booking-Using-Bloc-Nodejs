import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on(mapEventToState);
  }

  FutureOr<void> mapEventToState(
      AuthEvent event, Emitter<AuthState> emit) async {
    if (event is LoginButtonPressed) {
      emit(AuthLoading());

      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        final response = await http.post(
          Uri.parse('$uri/api/users/login'),
          body: json.encode({
            'email': event.email,
            'password': event.password,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final Map<String, dynamic> userData = data['data']['user'];
          final String token = data['token'];
          final String username = userData['username'];
          final String email = userData['email'];
          final String? avatar = userData['avatar'];
          final String? phoneNumber = userData['phone_number'];
          
          // final String email = data['email'];
          // final String password = data['password'];
          // Lưu token vào SharedPreferences
          await preferences.setString("token", token);
          // print(token);
          // print('Username: $username, Email: $email');
          // print(password);

          await Future.delayed(const Duration(milliseconds: 100), () async {
            return emit(AuthSuccess(
                user: User(
                    email: email,
                    username: username,
                    token: token,
                    avatar: avatar,
                    phone_number: phoneNumber)));
          });
        } else {
          return emit(const AuthFailure(
              error:
                  "Hãy chắc rằng bạn đã nhập đầy đủ thông tin hoặc chính xác tài khoản"));
        }
      } catch (error) {
        return emit(AuthFailure(error: error.toString()));
      }
    }
  }
}
