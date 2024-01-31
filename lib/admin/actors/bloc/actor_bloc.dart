import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_booking_app/core/respository/actor_repository.dart';
import 'package:movie_booking_app/models/actor_model.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final ActorRepository _actorRepository;
  ActorBloc(this._actorRepository) : super(ActorLoadingState()) {
    on<LoadSearchActorEvent>((event, emit) async{
      emit(ActorLoadingState());
      try {
        final room = await _actorRepository.getActorById(event.id ?? "");
        emit(ActorLoadedState(room));
      }
      catch (e) {
        emit(ActorErrorState(e.toString()));
      }
    });


  }
}
