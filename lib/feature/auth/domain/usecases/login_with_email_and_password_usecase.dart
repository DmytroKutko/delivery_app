import 'package:delivery_app/feature/auth/domain/repository/login_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginWithEmailAndPasswordUsecase {
  final LoginRepository repository;

  LoginWithEmailAndPasswordUsecase({required this.repository});

  Future<AuthResponse> loginWithEmailAndPassword(String email, String password){
    return repository.loginWithEmailAndPassword(email, password);
  }
}
