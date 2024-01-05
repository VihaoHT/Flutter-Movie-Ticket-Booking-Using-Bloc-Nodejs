part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
@override
List<Object> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<Movie> movies;

  const SearchLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}

class SearchErrorState extends SearchState {
  final String error;

  const SearchErrorState(this.error);
  @override
  List<Object> get props => [error];
}



