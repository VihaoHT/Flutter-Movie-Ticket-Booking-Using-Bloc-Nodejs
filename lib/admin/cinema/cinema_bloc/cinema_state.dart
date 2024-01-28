part of 'cinema_bloc.dart';

sealed class CinemaState extends Equatable {
  const CinemaState();
  
  @override
  List<Object> get props => [];
}

class CinemaLoadingState extends CinemaState {
  @override
  List<Object> get props => [];
}

class CinemaLoadedState extends CinemaState {
  final List<Cinema> cinema;

  const CinemaLoadedState( this.cinema);
  @override
  List<Object> get props => [cinema];
}

class CinemaErrorState extends CinemaState {
  final String error;

  const CinemaErrorState( this.error);


  @override
  List<Object> get props => [error];
}

