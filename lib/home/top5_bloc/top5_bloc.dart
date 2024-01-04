import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_booking_app/core/respository/top5_respository.dart';

import '../../models/movie_model.dart';

part 'top5_event.dart';
part 'top5_state.dart';

class Top5Bloc extends Bloc<Top5Event, Top5State> {
  final Top5Respository _top5respository;
  Top5Bloc(this._top5respository) : super(Top5LoadingState()) {
    on<LoadTop5Event>((event, emit) async {
      emit(Top5LoadingState());
      try {
        final top5 = await _top5respository.getTop5Movies();
        emit(Top5LoadedState(top5));
      } catch (e) {
        emit(Top5ErrorState(e.toString()));
      }
    });
  }
}
