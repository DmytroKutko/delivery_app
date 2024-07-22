part of 'login_bloc.dart';

@immutable
sealed class LoginState {}
sealed class LoginListener extends LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSignIn extends LoginState {}
final class LoginError extends LoginState {}

final class LoginRedirectToHomePage extends LoginListener {}
final class LoginErrorSignIn extends LoginListener {}
