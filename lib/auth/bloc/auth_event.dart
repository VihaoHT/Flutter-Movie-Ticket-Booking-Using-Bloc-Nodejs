part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final String passwordConfirm;
  final String username;

  const SignUpButtonPressed({required this.email, required this.password,required this.passwordConfirm,required this.username});

  @override
  List<Object> get props => [email, password,passwordConfirm,username];
}

class ForgotButtonPressed extends AuthEvent {
  final String email;

  const ForgotButtonPressed({required this.email});

  @override
  List<Object> get props => [email];
}

