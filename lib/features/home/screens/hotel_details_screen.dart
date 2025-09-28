import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelbooking/features/home/widgets/hotel_info_section.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/features/bookings/cubit/review_cubit.dart';
import '../cubit/hotel_cubit.dart';
import '../cubit/hotel_model.dart';
import '../widgets/hotel_details_header.dart';
import '../widgets/hotel_details_toggle.dart';
import '../widgets/hotel_details_content.dart';
import '../widgets/hotel_details_ratings.dart';
import '../widgets/hotel_booking_bottom_sheet.dart';

class HotelDetailsScreen extends HookWidget {
  final Hotel hotel;

  const HotelDetailsScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final showInfo = useState(true);
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight / 3;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HotelCubit(Supabase.instance.client)),
        BlocProvider(
          create:
              (_) =>
                  ReviewCubit(Supabase.instance.client)..fetchReviews(hotel.id),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton:
            showInfo.value
                ? FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.9,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                            child: Container(
                              color: Colors.white,
                              child: HotelBookingForm(
                                userId:
                                    Supabase
                                        .instance
                                        .client
                                        .auth
                                        .currentUser!
                                        .id,
                                hotelId: hotel.id,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  label: const Text(
                    'Book',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(Icons.hotel, color: Colors.white),
                  backgroundColor: const Color(0xFF165244),
                )
                : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            HotelDetailsHeader(hotel: hotel, imageHeight: imageHeight),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: HotelInfoSection(hotel: hotel),
            ),
            HotelDetailsToggle(showInfo: showInfo),
            Expanded(
              child:
                  showInfo.value
                      ? HotelDetailsContent(hotel: hotel)
                      : HotelDetailsRatings(hotelId: hotel.id),
            ),
          ],
        ),
      ),
    );
  }
}
