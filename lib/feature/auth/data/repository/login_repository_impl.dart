import 'package:delivery_app/feature/auth/domain/repository/login_repository.dart';
import 'package:delivery_app/feature/home/data/remote/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginRepositoryImpl extends LoginRepository {
  final SupabaseService supabaseService;

  LoginRepositoryImpl({required this.supabaseService});

  @override
  Future<AuthResponse> loginWithEmailAndPassword(
      String email, String password) async {
    return supabaseService.client.auth
        .signInWithPassword(email: email, password: password);
  }
  
  @override
  Session? getCurrentSession() {
    return supabaseService.client.auth.currentSession;
  }
}
