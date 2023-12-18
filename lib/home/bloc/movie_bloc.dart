import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_booking_app/core/respository/movie_respository.dart';
import 'package:movie_booking_app/models/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRespository _movieRespository;
  MovieBloc(this._movieRespository) : super(MovieLoadingState()) {
    on<LoadMovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        final movies = await _movieRespository.getMovies();
        emit(MovieLoadedState(movies));
      } catch (e) {
        emit(MovieErrorState(e.toString()));
      }
    });
  }
}
