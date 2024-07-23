part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

sealed class RegisterStateListener extends RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterError extends RegisterState {}

final class RegisterRedirectToEditProfilePage extends RegisterState {}
