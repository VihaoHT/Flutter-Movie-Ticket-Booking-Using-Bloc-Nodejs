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

class AddActorsEvent extends ActorEvent {
  final File avatar;
  final String name;
  final String dob;
  final String country;
  final BuildContext context;

  const AddActorsEvent({required this.avatar, required this.name, required this.dob, required this.country, required this.context});



  @override
  List<Object> get props => [avatar,name,dob,country,context];
}

class UpdateActorsEvent extends ActorEvent {
  final File? avatar;
  final String name;
  final String dob;
  final String country;
  final String actorID;
  final BuildContext context;

  const UpdateActorsEvent({required this.avatar, required this.name, required this.dob, required this.country,required this.actorID, required this.context});



  @override
  List<Object> get props => [avatar!,name,dob,country,actorID,context];
}



