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
  Future<AuthResponse> registerWithEmailAndPassword(
      String email, String password) async {
    final AuthResponse res = await supabaseService.client.auth.signUp(
      email: email.trim(),
      password: password.trim(),
    );
    final Session? session = res.session;
    final User? user = res.user;

    print("session: ${session?.accessToken}");
    print("user: ${user?.email}");
    return res;
  }

  @override
  Session? getCurrentSession() {
    return supabaseService.client.auth.currentSession;
  }
}
