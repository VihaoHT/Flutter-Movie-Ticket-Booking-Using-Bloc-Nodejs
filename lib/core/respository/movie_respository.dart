import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/models/movie_model.dart';

class MovieRespository {
  String api = "$uri/api/movies";


  Future<List<Movie>> getMovies() async {
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
      final List<dynamic> movies = data['data']['data'];
      // print(movies);

      // Map each JSON object to a Movie instance and return the list
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> getMoviesByNameAndCategory(String category, String title) async {
    // check if category and title is null
    if ((category == null || category.isEmpty) && (title == null || title.isEmpty)) {
      // return [] if category and title is null;
      return [];
    }

    String apiSearch = "$uri/api/movies?";

    if (category != null && category.isNotEmpty) {
      apiSearch += "category=$category";
    }

    if (title != null && title.isNotEmpty) {
      apiSearch += "${category.isEmpty ? '' : '&'}title=$title";
    }

    // Define the base URL and the endpoint
    final url = Uri.parse(apiSearch);

    // Make the HTTP GET request and await the response
    final response = await get(url);

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the response body as a map of JSON objects
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Get the list of movies from the data map
      final List<dynamic> movies = data['data'];
      //print(movies);

      // Map each JSON object to a Movie instance and return the list
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load movies ${response.statusCode}');
    }
  }

}
