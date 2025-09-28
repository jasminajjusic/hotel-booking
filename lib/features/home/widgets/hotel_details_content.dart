import 'package:flutter/material.dart';
import '../cubit/hotel_model.dart';
import 'hotel_amenities.dart';
import 'hotel_description.dart';
import 'hotel_location_map.dart';

class HotelDetailsContent extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailsContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amenities',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          HotelAmenities(),
          const SizedBox(height: 24),
          HotelDescription(description: hotel.description),
          const SizedBox(height: 24),
          HotelLocationMap(hotel: hotel),
        ],
      ),
    );
  }
}
