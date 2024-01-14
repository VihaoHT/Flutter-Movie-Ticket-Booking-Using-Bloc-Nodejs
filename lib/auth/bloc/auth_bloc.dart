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
    // this is for skip login if have token
    if (event is AppStarted) {
      final bool hasToken = await _hasToken();

      if (hasToken) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? token = preferences.getString('token');

        // the reason why i call api get info of user here is to save user information
        final response = await http.get(
          Uri.parse('$uri/api/users/me'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        final Map<String, dynamic> data = json.decode(response.body);
        final String id = data['data']['document']['_id'];
        final String email = data['data']['document']['email'];
        final String username = data['data']['document']['username'];
        final String? avatar = data['data']['document']['avatar'];
        final String? phoneNumber = data['data']['document']['phone_number'];
        final String role = data['data']['document']['role'];
        print(role);

        return emit(AuthSuccess(
            user: User(
                id: id,
                email: email,
                username: username,
                token: token!,
                role: role,
                avatar: avatar,
                phone_number: phoneNumber)));
      } else {
        emit(AuthInitial());
      }
    }

    // this is for Login event
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
          final String role = userData['role'];
          print(role);

          await preferences.setString("token", token);

          await Future.delayed(const Duration(milliseconds: 100), () async {
            return emit(AuthSuccess(
                user: User(
                    id: id,
                    email: email,
                    username: username,
                    token: token,
                    role: role,
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

    // this is for register event
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

    // this is for Forgot password event
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

    // this is for logout event
    if (event is LogOut) {
      emit(AuthLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('token');

        // you can also return it into AuthInitial but it will catch error so that why i will return it to AuthSuccess with all null
        return emit(AuthSuccess(
            user: User(id: "", email: "", username: "", token: "",role: "")));
      } catch (e) {
        throw Exception(e.toString());
      }
    }

    // this is for change password event
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

        if (response.statusCode == 200) {
          await Future.delayed(const Duration(milliseconds: 100), () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('token');
            return emit(AuthChangePasswordSuccess());
          });
        } else if (response.statusCode == 401) {
          return emit(
              const AuthFailure(error: "Current password is not correct!"));
        } else if (response.statusCode == 500) {
          return emit(const AuthFailure(
              error: "Password and Confirm password should be the same!"));
        }
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    }

    //this is for update profile event
    if (event is UpdateProfileButtonPressed) {
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
        if (response.statusCode == 200) {
          await Future.delayed(const Duration(milliseconds: 100), () async {
            final response = await http.get(
              Uri.parse('$uri/api/users/me'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
            );
            final Map<String, dynamic> data = json.decode(response.body);
            final String id = data['data']['document']['_id'];
            final String email = data['data']['document']['email'];
            final String role = data['data']['document']['role'];

            return emit(AuthSuccess(
                user: User(
                    id: id,
                    email: email,
                    username: event.username!,
                    token: token!,
                    role: role,
                    avatar: event.avatar,
                    phone_number: event.phone_number)));
          });
        } else {
          return emit(const AuthFailure(error: "Something went wrong!"));
        }
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    }
  }

  Future<bool> _hasToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token') ?? '';
    return token.isNotEmpty;
  }
}
