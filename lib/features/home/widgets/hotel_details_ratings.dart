import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelbooking/features/bookings/cubit/review_cubit.dart';
import 'package:hotelbooking/features/bookings/cubit/review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelDetailsRatings extends HookWidget {
  final String hotelId;

  const HotelDetailsRatings({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final selectedStars = useState(0);
    final commentController = useTextEditingController();

    void _showRatingSheet() {
      final reviewCubit = context.read<ReviewCubit>();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return BlocProvider.value(
            value: reviewCubit,
            child: HookBuilder(
              builder: (context) {
                final stars = useState(selectedStars.value);
                final comment = commentController;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Submit Your Rating",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < stars.value
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 32,
                            ),
                            onPressed: () => stars.value = index + 1,
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: comment,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Write your comment here...',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final userId =
                              Supabase.instance.client.auth.currentUser!.id;
                          context.read<ReviewCubit>().submitReview(
                            hotelId: hotelId,
                            profileId: userId,
                            rating: stars.value.toDouble(),
                            comment: comment.text,
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF165244),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReviewLoaded) {
                final reviews = state.reviews;
                if (reviews.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/review.svg',
                          width: 100,
                          height: 100,
                          color: const Color(0xFF165244),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "No reviews yet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final r = reviews[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF165244),
                          child: Text(
                            r.profileName[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r.profileName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    i < r.rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 16,
                                  );
                                }),
                              ),

                              Text(
                                r.comment,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is ReviewError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: _showRatingSheet,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF165244),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Submit Rating",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
