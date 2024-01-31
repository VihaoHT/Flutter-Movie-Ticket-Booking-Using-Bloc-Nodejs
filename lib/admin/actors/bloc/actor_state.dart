part of 'actor_bloc.dart';

sealed class ActorState extends Equatable {
  const ActorState();
  
  @override
  List<Object> get props => [];
}

class ActorLoadingState extends ActorState {
  @override
  List<Object> get props => [];
}

class ActorLoadedState extends ActorState {
  final List<Actor> actor;

  const ActorLoadedState( this.actor);
  @override
  List<Object> get props => [actor];
}

class ActorErrorState extends ActorState {
  final String error;

  const ActorErrorState( this.error);


  @override
  List<Object> get props => [error];
}



