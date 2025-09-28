import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final SupabaseClient supabase;

  ReviewCubit(this.supabase) : super(ReviewInitial());

  Future<void> fetchReviews(String hotelId) async {
    emit(ReviewLoading());

    try {
      final data =
          await supabase
                  .from('reviews')
                  .select(
                    'id, hotel_id, profile_id, rating, comment, created_at, profiles(name) as profile_name',
                  )
                  .eq('hotel_id', hotelId)
                  .order('created_at', ascending: false)
              as List<dynamic>;

      final reviews =
          data.map((r) => Review.fromMap(r as Map<String, dynamic>)).toList();
      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> submitReview({
    required String hotelId,
    required String profileId,
    required double rating,
    required String comment,
  }) async {
    try {
      await supabase.from('reviews').insert({
        'hotel_id': hotelId,
        'profile_id': profileId,
        'rating': rating,
        'comment': comment,
      });

      await fetchReviews(hotelId);
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
