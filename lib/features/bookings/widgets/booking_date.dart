import 'package:flutter/material.dart';

class BookingDateColumn extends StatelessWidget {
  final String label;
  final String date;

  const BookingDateColumn({super.key, required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF165244),
          ),
        ),
      ],
    );
  }
}
