import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/di/dependency_injection.dart';
import 'package:delivery_app/feature/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:delivery_app/feature/auth/domain/usecases/login_with_email_and_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Session? getCurrentSession() {
    return sl<GetCurrentSessionUsecase>().getCurrentSession();
  }

  final LoginWithEmailAndPasswordUsecase loginWithEmailAndPasswordUsecase =
      sl();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginInit>(loginInit);
    on<LoginSignInEvent>(loginSignInEvent);
    on<LoginContinueWithGoogle>(loginContinueWithGoogle);
    on<LoginSignUpEvent>(loginSignUpEvent);
  }

  FutureOr<void> loginInit(LoginInit event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    final currentSession = getCurrentSession();

    if (currentSession != null) {
      emit(LoginRedirectToHomePage());
    } else {
      emit(LoginSignInState());
    }
  }

  FutureOr<void> loginSignInEvent(
      LoginSignInEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());

      final result = await loginWithEmailAndPasswordUsecase
          .loginWithEmailAndPassword(event.email, event.password);

      if (result.session != null) {
        emit(LoginRedirectToHomePage());
      } else {
        emit(LoginSignInState());
        emit(LoginErrorSignIn());
      }
    } catch (e) {
      emit(LoginErrorSignIn());
      emit(LoginSignInState());
    }
  }

  FutureOr<void> loginContinueWithGoogle(
      LoginContinueWithGoogle event, Emitter<LoginState> emit) {}

  FutureOr<void> loginSignUpEvent(
      LoginSignUpEvent event, Emitter<LoginState> emit) {
    emit(LoginSignUp());
  }
}
