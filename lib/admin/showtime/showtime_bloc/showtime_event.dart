part of 'showtime_bloc.dart';

sealed class ShowtimeEvent extends Equatable {
  const ShowtimeEvent();

  @override
  List<Object> get props => [];
}

class LoadShowtimeEvent extends ShowtimeEvent {
  @override
  List<Object> get props => [];
}

class LoadSearchShowtimeEvent extends ShowtimeEvent {
  final String? title;

  const LoadSearchShowtimeEvent({required this.title});


  @override
  List<Object> get props => [title!];
}

class AddShowtimeEvent extends ShowtimeEvent {
  final String movieId;
  final String roomId;
  final DateTime startTime;
  final DateTime endTime;
  final int price;
  final BuildContext context;

  const AddShowtimeEvent({required this.movieId, required this.roomId, required this.startTime, required this.endTime, required this.price, required this.context});




  @override
  List<Object> get props => [movieId,roomId,startTime,endTime,price, context];
}