part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

sealed class EditProfileStateListener extends EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  final ProfileEntity profileData;

  EditProfileSuccess({required this.profileData});
}

final class EditProfileStateSuccessfulyUpdatedListener
    extends EditProfileStateListener {}
