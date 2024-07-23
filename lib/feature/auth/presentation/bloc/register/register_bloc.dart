import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/auth/domain/usecases/register_with_email_and_password_usecase.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterWithEmailAndPasswordUsecase
      registerWithEmailAndPasswordUsecase = sl();
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterInitialEvent>(registerInitialEvent);
    on<RegisterSignUpEvent>(registerSignUpEvent);
  }

  FutureOr<void> registerInitialEvent(
      RegisterInitialEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterSuccess());
  }

  FutureOr<void> registerSignUpEvent(
      RegisterSignUpEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    final String email = event.email;
    final String password = event.password;

    await registerWithEmailAndPasswordUsecase.registerWithEmailAndPassword(
        email, password);

    emit(RegisterRedirectToEditProfilePage());
  }
}
