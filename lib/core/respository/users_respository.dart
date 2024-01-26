import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';
import 'package:movie_booking_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class UserRepository {
  String api = "$uri/api/users";


  Future<List<User>> getUsers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final response = await get(
      Uri.parse(api),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> users = data['data']['data'];
      return users.map((user) => User.fromMap(user)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Failed to load users ${response.statusCode}');
    } else {
      throw Exception('Failed to load users ${response.statusCode}');
    }
  }

  Future<List<User>> getUsersByName(String name) async {
    String api = "$uri/api/users/search?username=$name";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final response = await get(
      Uri.parse(api),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> users = data['user'];
      if(name != null){
        return users.map((user) => User.fromMap(user)).toList();
      }else{
        return getUsers();
      }

    } else if (response.statusCode == 401) {
      throw Exception('Failed to load users ${response.statusCode}');
    } else {
      throw Exception('Failed to load users ${response.statusCode}');
    }
  }
}
