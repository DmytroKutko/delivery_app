import 'package:delivery_app/feature/auth/domain/repository/login_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetCurrentSessionUsecase {
  final LoginRepository repository;

  GetCurrentSessionUsecase({required this.repository});

  Session? getCurrentSession() {
    return repository.getCurrentSession();
  }
}
