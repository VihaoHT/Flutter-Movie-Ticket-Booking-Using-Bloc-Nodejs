part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}
class LoadUserEvent extends UsersEvent{

  @override
  List<Object> get props => [];
}

class SearchLoadUserEvent extends UsersEvent{
  final String name;

  const SearchLoadUserEvent({required this.name});
  @override
  List<Object> get props => [name];
}