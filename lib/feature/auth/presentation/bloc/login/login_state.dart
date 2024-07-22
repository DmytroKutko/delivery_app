part of 'login_bloc.dart';

@immutable
sealed class LoginState {}
sealed class LoginListener extends LoginState {}

final class LoginInitialState extends LoginState {}
final class LoginLoadingState extends LoginState {}
final class LoginSignInState extends LoginState {}
final class LoginErrorState extends LoginState {}

final class LoginRedirectToHomePage extends LoginListener {}
final class LoginErrorSignIn extends LoginListener {}
final class LoginSignUp extends LoginListener {}
