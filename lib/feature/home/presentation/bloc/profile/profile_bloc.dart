import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/home/domain/entity/profile_entity.dart';
import 'package:delivery_app/feature/home/domain/usecases/get_profile_data_usecase.dart';
import 'package:delivery_app/feature/home/domain/usecases/profile_sign_out_usecase.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDataUsecase profileDataUsecase = sl();

  final ProfileSignOutUsecase signOutUsecase = sl();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
    on<ProfileSignOutEvent>(profileSignOutEvent);
  }

  FutureOr<void> profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    final profile = await profileDataUsecase.getProfileData();

    emit(ProfileSuccess(profile: profile));
  }

  FutureOr<void> profileSignOutEvent(
      ProfileSignOutEvent event, Emitter<ProfileState> emit) {
    try {
      signOutUsecase.singOut();
      emit(ProfileRedirectToLoginPage());
    } on Exception catch (_) {}
  }
}
