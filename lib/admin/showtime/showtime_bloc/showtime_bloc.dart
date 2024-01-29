import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/respository/showtime_repository.dart';
import 'package:movie_booking_app/models/showtime_model.dart';

part 'showtime_event.dart';

part 'showtime_state.dart';

class ShowtimeBloc extends Bloc<ShowtimeEvent, ShowtimeState> {
  final ShowtimeRepository _showtimeRepository;

  ShowtimeBloc(this._showtimeRepository) : super(ShowtimeLoadingState()) {
    on<ShowtimeEvent>((event, emit) async {
      emit(ShowtimeLoadingState());
      try {
        final showtime = await _showtimeRepository.getShowtime();
        emit(ShowtimeLoadedState(showtime));
      } catch (e) {
        emit(ShowtimeErrorState(e.toString()));
      }
    });

    on<LoadSearchShowtimeEvent>((event, emit) async {
      emit(ShowtimeLoadingState());
      try {
        final showtime =
            await _showtimeRepository.getShowtimeByName(event.title ?? "");
        emit(ShowtimeLoadedState(showtime));
      } catch (e) {
        emit(ShowtimeErrorState(e.toString()));
      }
    });

    on<AddShowtimeEvent>((event, emit) async {
      emit(ShowtimeLoadingState());
      try {
        final showtime = await _showtimeRepository.addShowTime(
            event.movieId,
            event.roomId,
            event.startTime,
            event.endTime,
            event.price,
            event.context);
        emit(ShowtimeLoadedState(showtime));
      } catch (e) {
        emit(ShowtimeErrorState(e.toString()));
      }
    });
  }
}
