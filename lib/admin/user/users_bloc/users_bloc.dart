import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/respository/users_respository.dart';
import 'package:movie_booking_app/models/user_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository _userRepository;
  UsersBloc(this._userRepository) : super(UserLoadingState()) {
    on<UsersEvent>((event, emit) async{
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      }
      catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

  }
}