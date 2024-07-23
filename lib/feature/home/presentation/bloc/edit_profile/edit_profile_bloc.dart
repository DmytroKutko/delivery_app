import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_profile_data_usecase.dart';
import 'package:delivery_app/feature/home/domain/usecases/update_profile_usecase.dart';
import 'package:flutter/material.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetProfileDataUsecase getProfileDataUsecase =
      sl<GetProfileDataUsecase>();

  final UpdateProfileUsecase updateProfileUsecase = sl<UpdateProfileUsecase>();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileInit>(editProfileInit);
    on<EditProfileSaveChanges>(editProfileSaveChanges);
  }

  FutureOr<void> editProfileInit(
      EditProfileInit event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());

    final profileData = await getProfileDataUsecase.getProfileData();

    emit(EditProfileSuccess(profileData: profileData));
  }

  FutureOr<void> editProfileSaveChanges(
      EditProfileSaveChanges event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());

    final profileData = await updateProfileUsecase.updateProfile(
        event.image, event.profileEntity);

    emit(EditProfileStateSuccessfulyUpdatedListener());
    emit(EditProfileSuccess(profileData: profileData));
  }
}
