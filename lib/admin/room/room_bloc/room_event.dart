part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}
class LoadSearchRoomEvent extends RoomEvent {
  final String? id;

  const LoadSearchRoomEvent({required this.id});

  @override
  List<Object> get props => [id!];
}

class AddRoomEvent extends RoomEvent {
  final String roomName;
  final String cinemaId;
  final BuildContext context;

  const AddRoomEvent({required this.roomName, required this.cinemaId, required this.context});


  @override
  List<Object> get props => [roomName,cinemaId,context];
}

