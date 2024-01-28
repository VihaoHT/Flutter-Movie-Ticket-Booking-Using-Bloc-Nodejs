part of 'cinema_bloc.dart';

sealed class CinemaEvent extends Equatable {
  const CinemaEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchCinemaEvent extends CinemaEvent {
  final String? name;

  const LoadSearchCinemaEvent({required this.name});

  @override
  List<Object> get props => [name!];
}

class PostCinemaEvent extends CinemaEvent {
  final String name;
  final List<double> coordinates;
  final String address;
  final BuildContext context;

  const PostCinemaEvent(
      {required this.name,
      required this.coordinates,
      required this.address,
      required this.context});

  @override
  List<Object> get props => [name,coordinates,address,context];
}

class DeleteCinemaEvent extends CinemaEvent {
  final  String cinemaId;
  final BuildContext context;

  const DeleteCinemaEvent({required this.cinemaId, required this.context});



  @override
  List<Object> get props => [cinemaId,context];
}
