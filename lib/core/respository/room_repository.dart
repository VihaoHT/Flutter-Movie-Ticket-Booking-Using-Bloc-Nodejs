import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../models/room_model.dart';
import '../constants/constants.dart';
import '../constants/ultis.dart';

class RoomRepository {
  String api = "$uri/api/rooms";

  Future<List<Room>> getRoom() async {
    final url = Uri.parse(api);
    final response = await get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> rooms = data['data']['data'];

        return rooms.map((room) => Room.fromJson(room)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Room>> getRoomById(String id) async {
    String api = "$uri/api/rooms?_id=$id";
    if(id.isEmpty || id == null){
      return getRoom();
    }
    final url = Uri.parse(api);
    final response = await get(url);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> rooms = data['data']['data'];

        return rooms.map((room) => Room.fromJson(room)).toList();
      } else {
        return getRoom();
      }
    } catch (e) {
      return getRoom();
    }
  }

  Future<List<Room>> postNewRoom(String roomName,
      String cinemaId, BuildContext context) async {
    final res = (await post(Uri.parse(api),
        body: json.encode({
          'name': roomName,
          'cinema': cinemaId
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }));
    try {
      if (res.statusCode == 201) {
        if (context.mounted) {
          navigator!.pop(context);
          showToastSuccess(context, "Add new Room successfully!");
        }
        return getRoom();
      } else {
        if (context.mounted) {
          showToastFailed(
              context, "Add new room failed! with ${res.statusCode}");
        }
        return getRoom();
      }
    } catch (e) {
      if (context.mounted) {
        showToastFailed(
            context, "Add new room failed! with ${res.statusCode}");
      }
      return getRoom();
    }
  }
}
