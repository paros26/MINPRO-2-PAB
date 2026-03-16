import '../config/supabase_config.dart';

class AuthService {

  final supabase = SupabaseConfig.client;

  Future login(String email, String password) async {

    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response;
  }

  Future register(String email, String password) async {

    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    return response;
  }

  Future logout() async {

    await supabase.auth.signOut();

  }

}