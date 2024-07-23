part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterSignUpEvent extends RegisterEvent {
  final String email;
  final String password;

  RegisterSignUpEvent({required this.email, required this.password});
}
