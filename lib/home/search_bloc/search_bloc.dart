import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_booking_app/core/respository/movie_respository.dart';

import '../../models/movie_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRespository _movieRespository;
  SearchBloc(this._movieRespository) : super(SearchLoadingState()) {
    on<LoadSearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        final searchMovies = await _movieRespository.getMoviesByNameAndCategory(event.category ?? "", event.title ?? "");
        emit(SearchLoadedState(searchMovies));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });
  }
}

