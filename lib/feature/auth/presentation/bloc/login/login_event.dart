part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginInit extends LoginEvent {}

class LoginSignInEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSignInEvent({required this.email, required this.password});
}

class LoginContinueWithGoogle extends LoginEvent {}
