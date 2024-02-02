import 'dart:convert';
import 'dart:io';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_booking_app/models/actor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../constants/ultis.dart';

class ActorRepository{
  String api = "$uri/api/actors";

  Future<List<Actor>> getActor() async {
    final url = Uri.parse(api);
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> actors = data['data']['data'];

        return actors.map((actor) => Actor.fromJson(actor)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Actor>> getActorById(String id) async {
    String api = "$uri/api/actors?_id=$id";
    if(id.isEmpty || id == null){
      return getActor();
    }
    final url = Uri.parse(api);
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> actors = data['data']['data'];

        return actors.map((actor) => Actor.fromJson(actor)).toList();
      } else {
        return getActor();
      }
    } catch (e) {
      return getActor();
    }
  }

  Future<List<Actor>> addNewActor(
      File avatar,
      String name,
      String country,
      String dob,
      BuildContext context) async {
    try {
      String api = "$uri/api/actors/add";
      Dio dio = Dio();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      // Use the correct Content-Type header
      final options = Options(
        headers: {
          'Content-Type': 'application/json' 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          avatar.path,
        ),
        'name': name,
        'dob': dob,
        'country': country
      });

      Response response = await dio.post(
        api,
        data: formData,
        options: options,
      );
      if (response.statusCode == 201) {
        if (context.mounted) {
          navigator!.pop(context);
          showToastSuccess(context, "Actor added successfully!");
        }
        return getActor();
      } else {
       // print(response.statusCode);
        return getActor();
      }
    } catch (e) {
     // print(e.toString());
      return getActor();
    }
  }

  Future<List<Actor>> updateActor(
      File avatar,
      String name,
      String country,
      String dob,
      String actorID,
      BuildContext context) async {
    try {
      String api = "$uri/api/actors/update/$actorID";
      Dio dio = Dio();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      // Use the correct Content-Type header
      final options = Options(
        headers: {
          'Content-Type': 'application/json' 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          avatar.path,
        ),
        'name': name,
        'dob': dob,
        'country': country
      });

      Response response = await dio.patch(
        api,
        data: formData,
        options: options,
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
        navigator!.pop(context);
        showToastSuccess(context, "Actor update successfully!");
      }
        return getActor();
      } else {
        print(response.statusCode);
        return getActor();
      }
    } catch (e) {
      return getActor();
    }
  }
}