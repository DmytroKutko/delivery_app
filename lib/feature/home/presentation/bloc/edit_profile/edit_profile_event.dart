part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class EditProfileInit extends EditProfileEvent {}
class EditProfileSaveChanges extends EditProfileEvent {
  final File? image;
  final ProfileEntity profileEntity;

  EditProfileSaveChanges({required this.image, required this.profileEntity});
}
