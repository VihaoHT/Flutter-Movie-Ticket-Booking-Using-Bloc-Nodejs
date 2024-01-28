import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/respository/cinema_repository.dart';
import 'package:movie_booking_app/models/cinema_model.dart';

part 'cinema_event.dart';
part 'cinema_state.dart';

class CinemaBloc extends Bloc<CinemaEvent, CinemaState> {
  final CinemaRepository _cinemaRepository;
  CinemaBloc(this._cinemaRepository) : super(CinemaLoadingState()) {
    on<LoadSearchCinemaEvent>((event, emit) async{
      emit(CinemaLoadingState());
      try {
        final cinema = await _cinemaRepository.getCinemaByName(event.name ?? "");
        emit(CinemaLoadedState(cinema));
      }
      catch (e) {
        emit(CinemaErrorState(e.toString()));
      }
    });

    on<PostCinemaEvent>((event, emit) async{
      emit(CinemaLoadingState());
      try {
        final cinema = await _cinemaRepository.postNewCinema(event.name, event.coordinates, event.address, event.context);
        emit(CinemaLoadedState(cinema));
      }
      catch (e) {
        emit(CinemaErrorState(e.toString()));
      }
    });

  }
}
