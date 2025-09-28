import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthenticationState> {
  final SupabaseClient supabase;

  AuthCubit(this.supabase) : super(AuthInitial());

  Future<void> register(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user != null) {
        await supabase.from('profiles').insert({'id': user.id, 'name': name});
        emit(AuthSuccess("Registration successful"));
      } else {
        emit(AuthFailure("Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure("Registration error: ${e.toString()}"));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        emit(AuthSuccess("Login successful"));
      } else {
        emit(AuthFailure("Invalid credentials"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final response = await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
      );
      if (response != null) {
        emit(AuthSuccess("Google login initiated"));
      } else {
        emit(AuthFailure("Google login failed"));
      }
    } catch (e) {
      emit(AuthFailure("Google login error: ${e.toString()}"));
    }
  }

  Future<void> loginWithFacebook() async {
    emit(AuthLoading());
    try {
      final response = await supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
      );
      if (response != null) {
        emit(AuthSuccess("Facebook login initiated"));
      } else {
        emit(AuthFailure("Facebook login failed"));
      }
    } catch (e) {
      emit(AuthFailure("Facebook login error: ${e.toString()}"));
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    emit(AuthInitial());
  }
}
