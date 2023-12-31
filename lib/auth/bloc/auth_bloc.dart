import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
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
          final String id = userData['_id'];
          final String username = userData['username'];
          final String email = userData['email'];
          final String? avatar = userData['avatar'];
          final String? phoneNumber = userData['phone_number'];
          //  print(id);
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
                    id: id,
                    email: email,
                    username: username,
                    token: token,
                    avatar: avatar,
                    phone_number: phoneNumber)));
          });
        } else if (response.statusCode == 400) {
          return emit(
              const AuthFailure(error: "Please provide email and password!"));
        } else if (response.statusCode == 401) {
          return emit(const AuthFailure(error: "Incorrect email or password"));
        }
      } catch (error) {
        return emit(AuthFailure(error: error.toString()));
      }
    }
    if (event is SignUpButtonPressed) {
      emit(AuthLoading());

      try {
        final response = await http.post(
          Uri.parse('$uri/api/users/register'),
          body: json.encode({
            'email': event.email,
            'password': event.password,
            'passwordConfirm': event.passwordConfirm,
            'username': event.username
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 201) {
          await Future.delayed(const Duration(milliseconds: 100), () async {
            return emit(AuthSignUpSuccess());
          });
        } else if (response.statusCode == 500) {
          return emit(const AuthFailure(error: "Please provide a valid email"));
        } else if (response.statusCode == 400) {
          return emit(const AuthFailure(error: "Email have been used!"));
        }
      } catch (error) {
        return emit(AuthFailure(error: error.toString()));
      }
    }

    //notice: if you dont see the email sent to inbox in gmail please check in spam or trash
    if (event is ForgotButtonPressed) {
      emit(AuthLoading());

      try {
        final response = await http.post(
          Uri.parse('$uri/api/users/forget-password'),
          body: json.encode({
            'email': event.email,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          await Future.delayed(const Duration(milliseconds: 100), () async {
            return emit(AuthForgotSuccess());
          });
        } else if (response.statusCode == 500) {
          return emit(const AuthFailure(
              error: "There was an error sending the email. Try again later!"));
        } else if (response.statusCode == 404) {
          return emit(
              const AuthFailure(error: "There is no user with email address!"));
        }
      } catch (error) {
        return emit(AuthFailure(error: error.toString()));
      }
    }
    if (event is LogOut) {
      emit(AuthLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        emit(LoggedOutState());
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    }

    if (event is ChangePasswordButtonPressed) {
      emit(AuthLoading());
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? token = preferences.getString('token');
        final response = await http.patch(
          Uri.parse('$uri/api/users/change-password'),
          body: json.encode({
            'password': event.password,
            'newpassword': event.newPassword,
            'passwordconfirm': event.passwordConfirm
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if(response.statusCode == 200){
          await Future.delayed(const Duration(milliseconds: 100), () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('token');
            return emit(AuthChangePasswordSuccess());
          });
        }else if (response.statusCode == 401) {
          return emit(const AuthFailure(
              error: "Current password is not correct!"));
        }
        else if (response.statusCode == 500) {
          return emit(const AuthFailure(
              error: "Password and Confirm password should be the same!"));
        }
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    }

    if(event is AvatarButtonPressed){
      emit(AuthLoading());
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? token = preferences.getString('token');

        final url = '$uri/api/users/update-user-avatar';
        var requestBody = {
          'avatar':event.avatar,
        };
        http.Response response = await http.patch(
          Uri.parse(url),
          body: json.encode(requestBody),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if(response.statusCode == 201){
          await Future.delayed(const Duration(milliseconds: 100), () async {
            return emit(AuthAvatarSuccess());
          });
        }else {
          return emit(const AuthFailure(
              error: "Something went wrong!"));
        }
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    }
    if(event is UpdateProfileButtonPressed){
      emit(AuthLoading());
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? token = preferences.getString('token');
        final response = await http.patch(
          Uri.parse('$uri/api/users/update-me'),
          body: json.encode({
            'avatar': event.avatar,
            'username': event.username,
            'phone_number': event.phone_number,

          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if(response.statusCode == 200){
          await Future.delayed(const Duration(milliseconds: 100), () async {
            return emit(AuthUpdateProfileSuccess());
          });
        }else {
          return emit(const AuthFailure(
              error: "Something went wrong!"));
        }
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    }
  }
}
