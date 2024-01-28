import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/models/cinema_model.dart';

import '../constants/ultis.dart';

class CinemaRepository {
  String api = "$uri/api/cinemas";

  Future<List<Cinema>> getCinemas() async {
    final url = Uri.parse(api);
    final response = await get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> cinemas = data['data']['data'];
        return cinemas.map((cinema) => Cinema.fromJson(cinema)).toList();
      } else {
        throw Exception('Failed to load Reviews');
      }
    } catch (e) {
      throw Exception('Failed to load Reviews');
    }
  }

  Future<List<Cinema>> getCinemaByName(String name) async {
    if (name.isEmpty) {
      return getCinemas();
    }
    String apiSearch = "$uri/api/cinemas?name=$name";
    final url = Uri.parse(apiSearch);
    final response = await get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> cinemas = data['data']['data'];
        return cinemas.map((cinema) => Cinema.fromJson(cinema)).toList();
      } else {
        return getCinemas();
      }
    } catch (e) {
      return getCinemas();
    }
  }

  Future<List<Cinema>> postNewCinema(
      String name,
      List<double> coordinates,
      String address,
      BuildContext context) async {
    try {
      final res = (await post(Uri.parse(api),
          body: json.encode({
            'name': name,
            'location': {
              'coordinates': coordinates,
              'address': address
            }
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          }));
      if (res.statusCode == 201) {
        if(context.mounted) {
          showToastSuccess(context, "Add new Cinema successfully!");
        }
        return getCinemas();
      } else {
        if (context.mounted) {
          showToastFailed(context, "Add new cinema failed! with ${res.statusCode}");
        }
        return getCinemas();
      }
    } catch (e) {
      throw Exception("failed");
    }
  }
}
