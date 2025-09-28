import 'package:flutter/material.dart';
import 'booking_status.dart';
import 'booking_actions.dart';
import 'booking_date.dart';

class BookingCard extends StatelessWidget {
  final Map booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStatus(booking: booking),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BookingDateColumn(label: 'Check-in', date: booking["check_in"]),
                Container(height: 40, width: 1, color: Colors.grey.shade300),
                BookingDateColumn(
                  label: 'Check-out',
                  date: booking["check_out"],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (booking.containsKey("total_price"))
              Text(
                'Total Price: \$${booking["total_price"]}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            const SizedBox(height: 12),
            BookingActions(booking: booking),
          ],
        ),
      ),
    );
  }
}
