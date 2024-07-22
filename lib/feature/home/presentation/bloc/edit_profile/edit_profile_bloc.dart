import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_profile_data_usecase.dart';
import 'package:flutter/material.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final Future<ProfileEntity> getProfileData =
      sl<GetProfileDataUsecase>().getProfileData();
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileInit>(editProfileInit);
  }

  FutureOr<void> editProfileInit(
      EditProfileInit event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());

    final profileData = await getProfileData;

    emit(EditProfileSuccess(profileData: profileData));
  }
}
