import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class UserRepository {
  String apiMyTicket = "$uri/api/tickets/user";

  Future<List<dynamic>> fetchMyTicket() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final response = await get(
      Uri.parse(apiMyTicket),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> tickets = data['data']['tickets'];
      //print(tickets);

      return tickets;
    } else if (response.statusCode == 401) {
      //print(response.statusCode);
      throw Exception('Failed to load tickets');
    } else {
      throw Exception('Failed to load tickets');
    }
  }
}
