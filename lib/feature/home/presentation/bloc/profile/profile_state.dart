part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

sealed class ProfileStateListener extends ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileEntity profile;

  ProfileSuccess({required this.profile});
}

final class ProfileError extends ProfileState {}

final class ProfileRedirectToLoginPage extends ProfileStateListener {}
