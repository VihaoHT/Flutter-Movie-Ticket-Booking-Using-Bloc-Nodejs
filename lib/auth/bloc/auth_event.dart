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

class LogOut extends AuthEvent {

  @override
  List<Object> get props => [];
}

class ChangePasswordButtonPressed extends AuthEvent {
  final String password;
  final String newPassword;
  final String passwordConfirm;

  const ChangePasswordButtonPressed({required this.password, required this.newPassword, required this.passwordConfirm});



  @override
  List<Object> get props => [password,newPassword,passwordConfirm];
}


class UpdateProfileButtonPressed extends AuthEvent {
  final String? avatar;
  final String? username;
  final String? phone_number;

  const UpdateProfileButtonPressed(this.avatar, this.username, this.phone_number);




  @override
  List<Object> get props => [avatar ?? "",username ?? "",phone_number ?? ""];
}




