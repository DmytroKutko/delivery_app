import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/home/domain/usecases/profile_sign_out_usecase.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileSignOutUsecase signOutUsecase = sl();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
    on<ProfileSignOutEvent>(profileSignOutEvent);
  }

  FutureOr<void> profileInitialEvent(ProfileInitialEvent event, Emitter<ProfileState> emit) {
    emit(ProfileLoading());

    emit(ProfileSuccess());
  }


  FutureOr<void> profileSignOutEvent(
      ProfileSignOutEvent event, Emitter<ProfileState> emit) {
    try {
      signOutUsecase.singOut();
      emit(ProfileRedirectToLoginPage());
    } on Exception catch (_) {}
  }
}
