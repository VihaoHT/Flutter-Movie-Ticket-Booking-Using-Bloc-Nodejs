import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/respository/room_repository.dart';
import 'package:movie_booking_app/models/room_model.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository _roomRepository;
  RoomBloc(this._roomRepository) : super(RoomLoadingState()) {
    on<LoadSearchRoomEvent>((event, emit) async{
      emit(RoomLoadingState());
      try {
        final room = await _roomRepository.getRoomById(event.id ?? "");
        emit(RoomLoadedState(room));
      }
      catch (e) {
        emit(RoomErrorState(e.toString()));
      }
    });


    on<AddRoomEvent>((event, emit) async{
      emit(RoomLoadingState());
      try {
        final room = await _roomRepository.postNewRoom(event.roomName, event.cinemaId, event.context);
        emit(RoomLoadedState(room));
      }
      catch (e) {
        emit(RoomErrorState(e.toString()));
      }
    });
  }
}
