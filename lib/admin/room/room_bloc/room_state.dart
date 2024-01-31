part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  const RoomState();
  
  @override
  List<Object> get props => [];
}

class RoomLoadingState extends RoomState {
  @override
  List<Object> get props => [];
}

class RoomLoadedState extends RoomState {
  final List<Room> room;

  const RoomLoadedState( this.room);
  @override
  List<Object> get props => [room];
}

class RoomErrorState extends RoomState {
  final String error;

  const RoomErrorState( this.error);


  @override
  List<Object> get props => [error];
}


