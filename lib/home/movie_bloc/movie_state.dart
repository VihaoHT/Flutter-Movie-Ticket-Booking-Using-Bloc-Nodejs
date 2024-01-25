part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;

  const MovieLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}


class MovieErrorState extends MovieState {
  final String error;

  const MovieErrorState(this.error);
  @override
  List<Object> get props => [error];
}
