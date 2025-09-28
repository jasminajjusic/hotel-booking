import 'package:flutter/material.dart';

import '../cubit/hotel_model.dart';

import 'hotel_image_header.dart';

class HotelDetailsHeader extends StatelessWidget {
  final Hotel hotel;
  final double imageHeight;

  const HotelDetailsHeader({
    super.key,
    required this.hotel,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return HotelImageHeader(hotel: hotel, imageHeight: imageHeight);
  }
}
