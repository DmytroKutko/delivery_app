import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRepository {
   Future<AuthResponse> loginWithEmailAndPassword(String email, String password);
   Session? getCurrentSession();
}