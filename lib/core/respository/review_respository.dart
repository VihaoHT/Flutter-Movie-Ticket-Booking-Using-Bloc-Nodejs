import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_booking_app/models/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class ReviewRespository{
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

      // Map each JSON object to a Movie instance and return the list
      return reviews.map((review) => Review.fromJson(review)).toList();
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load movies');
    }
  }

  Future<Review> postReviews(String review,double rating) async {
    // String api = "$uri/api/users/652c13658f6c95d46e4c2822";
    // // Define the base URL and the endpoint
    // final url = Uri.parse(api);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Make the HTTP GET request and await the response
    // final response = await get(url);
    String? token = preferences.getString('token');
    Response res = await post(
        Uri.parse(api), body: json.encode({
      'review': review,
      'rating': rating.toDouble(),
    }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
    // Check if the response status code is 200 (OK)
    if (res.statusCode == 201) {
      // Parse the response body as a map of JSON objects
      final Map<String, dynamic> data = jsonDecode(res.body);

      return Review.fromJson(data['data']);

    } else {
      // Throw an exception if the response status code is not 200
      throw Exception(res.statusCode);
    }
  }
}