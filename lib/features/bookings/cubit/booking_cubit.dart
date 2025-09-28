import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final SupabaseClient supabase;

  BookingCubit(this.supabase) : super(BookingState());

  Future<void> createBooking({
    required String userId,
    required String hotelId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    emit(state.copyWith(loading: true, error: null, success: false));
    try {
      final hotel =
          await supabase
              .from("hotels")
              .select("price")
              .eq("id", hotelId)
              .single();

      final double pricePerNight = (hotel["price"] as num).toDouble();
      final int nights = checkOut.difference(checkIn).inDays;
      final double totalPrice = pricePerNight * nights;

      await supabase.from("bookings").insert({
        "user_id": userId,
        "hotel_id": hotelId,
        "check_in": checkIn.toIso8601String(),
        "check_out": checkOut.toIso8601String(),
        "total_price": totalPrice,
        "status": "pending",
      });

      emit(state.copyWith(loading: false, success: true));
      await fetchUserBookings();
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> fetchUserBookings() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) {
      emit(state.copyWith(loading: false, error: "No user logged in"));
      return;
    }

    final userId = currentUser.id;
    emit(state.copyWith(loading: true, error: null, success: false));

    try {
      final data = await supabase
          .from("bookings")
          .select("*")
          .eq("user_id", userId)
          .order("check_in", ascending: true);

      emit(state.copyWith(loading: false, bookings: data, success: true));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    emit(state.copyWith(loading: true, error: null, success: false));
    try {
      await supabase
          .from("bookings")
          .update({"status": "cancelled"})
          .eq("id", bookingId);

      emit(state.copyWith(loading: false, success: true));
      await fetchUserBookings();
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> payBooking(String bookingId) async {
    emit(state.copyWith(loading: true, error: null, success: false));
    try {
      await supabase
          .from("bookings")
          .update({"status": "confirmed"})
          .eq("id", bookingId);

      emit(state.copyWith(loading: false, success: true));
      await fetchUserBookings();
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
