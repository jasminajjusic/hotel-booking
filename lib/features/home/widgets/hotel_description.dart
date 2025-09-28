import 'package:flutter/material.dart';

class HotelDescription extends StatelessWidget {
  final String description;

  const HotelDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
        ),
      ],
    );
  }
}
