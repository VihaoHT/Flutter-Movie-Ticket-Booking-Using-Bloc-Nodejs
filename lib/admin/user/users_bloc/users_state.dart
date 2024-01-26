part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UsersState {
  final List<User> users;

  const UserLoadedState(this.users);
  @override
  List<Object> get props => [users];
}
class SearchUserLoadedState extends UsersState {
  final List<User> users;

  const SearchUserLoadedState(this.users);
  @override
  List<Object> get props => [users];
}

class UserErrorState extends UsersState {
  final String error;

  const UserErrorState(this.error);
  @override
  List<Object> get props => [error];
}

