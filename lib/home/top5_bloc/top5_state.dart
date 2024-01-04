part of 'top5_bloc.dart';

sealed class Top5State extends Equatable {
  const Top5State();
  
  @override
  List<Object> get props => [];
}

class Top5LoadingState extends Top5State {
  @override
  List<Object> get props => [];
}

class Top5LoadedState extends Top5State {
  final List<Movie> movies;

  const Top5LoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}

class Top5ErrorState extends Top5State {
  final String error;

  const Top5ErrorState(this.error);
  @override
  List<Object> get props => [error];
}


