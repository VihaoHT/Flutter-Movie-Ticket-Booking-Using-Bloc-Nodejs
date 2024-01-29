part of 'showtime_bloc.dart';

sealed class ShowtimeState extends Equatable {
  const ShowtimeState();
  
  @override
  List<Object> get props => [];
}

class ShowtimeLoadingState extends ShowtimeState {
  @override
  List<Object> get props => [];
}

class ShowtimeLoadedState extends ShowtimeState {
  final List<ShowTime> showtimes;

  const ShowtimeLoadedState(this.showtimes);
  @override
  List<Object> get props => [showtimes];
}

class ShowtimeErrorState extends ShowtimeState {
  final String error;

  const ShowtimeErrorState(this.error);
  @override
  List<Object> get props => [error];
}


