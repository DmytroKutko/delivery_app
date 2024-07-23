import 'package:delivery_app/feature/auth/domain/repository/login_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterWithEmailAndPasswordUsecase {
  final LoginRepository repository;

  RegisterWithEmailAndPasswordUsecase({required this.repository});

  Future<AuthResponse> registerWithEmailAndPassword(
      String email, String password) {
    return repository.registerWithEmailAndPassword(email, password);
  }
}
