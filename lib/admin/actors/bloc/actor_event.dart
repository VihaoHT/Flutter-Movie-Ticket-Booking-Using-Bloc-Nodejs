part of 'actor_bloc.dart';

sealed class ActorEvent extends Equatable {
  const ActorEvent();

  @override
  List<Object> get props => [];
}
class LoadSearchActorEvent extends ActorEvent {
  final String? id;

  const LoadSearchActorEvent({required this.id});

  @override
  List<Object> get props => [id!];
}

// class AddRoomEvent extends ActorEvent {
//   final String roomName;
//   final String cinemaId;
//   final BuildContext context;
//
//   const AddRoomEvent({required this.roomName, required this.cinemaId, required this.context});
//
//
//   @override
//   List<Object> get props => [roomName,cinemaId,context];
// }


