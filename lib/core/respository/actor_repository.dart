import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_booking_app/models/actor_model.dart';

import '../constants/constants.dart';

class ActorRepository{
  String api = "$uri/api/actors";

  Future<List<Actor>> getActor() async {
    final url = Uri.parse(api);
    final response = await get(url);
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
    final response = await get(url);
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
}