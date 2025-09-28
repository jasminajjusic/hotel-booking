import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/features/profile/data/models/profile_model.dart';

class ProfileCubit extends Cubit<Profile> {
  ProfileCubit()
    : super(
        Profile(
          name: '',
          dateOfBirth: DateTime(2000, 1, 1),
          country: '',
          phoneNumber: '',
        ),
      );

  void upsertName(String name) {
    emit(state.copyWith(name: name));
  }

  void upsertDateOfBirth(DateTime date) {
    emit(state.copyWith(dateOfBirth: date));
  }

  void upsertCountry(String country) {
    emit(state.copyWith(country: country));
  }

  void upsertPhoneNumber(String phone) {
    emit(state.copyWith(phoneNumber: phone));
  }

  Future<void> saveProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    await Supabase.instance.client
        .from('profiles')
        .update(state.toJson())
        .eq('id', userId);
  }

  Future<void> loadProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    final response =
        await Supabase.instance.client
            .from('profiles')
            .select()
            .eq('id', userId)
            .single();

    if (response != null && response is Map<String, dynamic>) {
      emit(Profile.fromJson(response));
    }
  }
}
