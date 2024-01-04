import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/models/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class ReviewRespository {
  late String movieId; // Trường mới để lưu trữ movieId

  ReviewRespository(this.movieId);

  String get api => "$uri/api/movies/$movieId/reviews";

  Future<List<Review>> getReview() async {
    // Define the base URL and the endpoint
    final url = Uri.parse(api);

    // Make the HTTP GET request and await the response
    final response = await get(url);

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the response body as a map of JSON objects
      final Map<String, dynamic> data = jsonDecode(response.body);
      //print(data);

      // Get the list of movies from the data map
      final List<dynamic> reviews = data['data'];
      // print(movies);

      // Map each JSON object to a Review instance and return the list
      return reviews.map((review) => Review.fromJson(review)).toList();
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load Reviews');
    }
  }

  Future<List<Review>> postReviews(String review, double rating,BuildContext context) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    Response res = await post(Uri.parse(api),
        body: json.encode({
          'review': review,
          'rating': rating,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
    if (res.statusCode == 201) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Review posted successfully!'),
          duration: Duration(
              seconds: 4),
        ),
      );
      }

      return getReview();
    } else {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You just can review one time!'),
          duration: Duration(
              seconds: 4),
        ),
      );
      }

      return getReview();

    }
  }
}
