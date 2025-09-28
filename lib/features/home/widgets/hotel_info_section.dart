import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelbooking/features/home/cubit/hotel_model.dart';

class HotelInfoSection extends StatelessWidget {
  final Hotel hotel;

  const HotelInfoSection({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hotel.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: '£${hotel.price.toStringAsFixed(2)}'),
                  TextSpan(
                    text: ' / night',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/location.svg',
                  width: 16,
                  height: 16,
                  color: Colors.black,
                ),
                const SizedBox(width: 4),
                Text(
                  hotel.location,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.deepOrange, size: 16),
                const SizedBox(width: 4),
                Text(
                  hotel.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
