import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/models/showtime_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/review_model.dart';
import '../constants/constants.dart';
import '../constants/ultis.dart';

class ShowtimeRepository {
  String api = "$uri/api/showtimes";

  Future<List<ShowTime>> getShowtime() async {
    final url = Uri.parse(api);
    final response = await get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> showtimes = data['data'];
        // print(showtimes);

        return showtimes
            .map((showtime) => ShowTime.fromJson(showtime))
            .toList();
      } else {
        //print("${response.statusCode}");
        return [];
      }
    } catch (e) {
      //print("$e${response.statusCode}");
      return [];
    }
  }

  Future<List<ShowTime>> getShowtimeByName(String title) async {
    if (title.isEmpty) {
      return getShowtime();
    }

    String apiSearch = "$uri/api/showtimes?title=$title";
    final url = Uri.parse(apiSearch);
    final response = await get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> showtimes = data['data'];

        return showtimes
            .map((showtime) => ShowTime.fromJson(showtime))
            .toList();
      } else {
        //print(response.statusCode);
        return getShowtime();
      }
    } catch (e) {
      //print("$e${response.statusCode}");
      return getShowtime();
    }
  }

  Future<List<ShowTime>> addShowTime(
    String movieId,
    String roomId,
    String startTime,
    String endTime,
    int price,
    BuildContext context,
  ) async {
    final response = await post(Uri.parse(api),
        body: json.encode({
          'movie': movieId,
          'room': roomId,
          'start_time': startTime,
          'end_time': endTime,
          'price': price
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
    try {
      if (response.statusCode == 201) {
        if (context.mounted) {
          navigator!.pop(context);
          showToastSuccess(context, 'Add new Showtime successfully!');
        }

        return getShowtime();
      } else {
        if (context.mounted) {
          showToastFailed(
              context, "Add showtime failed at ${response.statusCode}!");
        }
        return getShowtime();
      }
    } catch (e) {
      if (context.mounted) {
        showToastFailed(
            context, "Add showtime failed at ${response.statusCode}!");
      }
      return getShowtime();
    }
  }
}
