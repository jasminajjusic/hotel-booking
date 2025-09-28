import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'hotel_state.dart';
import 'hotel_model.dart';

class HotelCubit extends Cubit<HotelState> {
  final SupabaseClient supabase;

  HotelCubit(this.supabase) : super(HotelInitial());

  Future<void> fetchHotels({String? searchQuery}) async {
    try {
      emit(HotelLoading());

      var query = supabase.from('hotels').select();

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('name', '%$searchQuery%');
      }

      final response = await query.order('created_at', ascending: false);

      final hotelList =
          (response as List).map((data) => Hotel.fromJson(data)).toList();

      emit(HotelLoaded(hotelList));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }

  Future<void> toggleFavorite(String hotelId, bool isFavorite) async {
    try {
      final response =
          await supabase
              .from('hotels')
              .update({'favorite': isFavorite})
              .eq('id', hotelId)
              .select();

      if (response.isEmpty) {
        emit(HotelError('Update failed'));
        return;
      }

      if (state is HotelLoaded) {
        final hotels =
            (state as HotelLoaded).hotels.map((hotel) {
              if (hotel.id == hotelId) {
                return hotel.copyWith(favorite: isFavorite);
              }
              return hotel;
            }).toList();

        emit(HotelLoaded(hotels));
      }
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }
}
