import 'package:flutter/material.dart';
import 'package:hotelbooking/features/bookings/widgets/booking_card.dart';

class BookingList extends StatelessWidget {
  final List bookings;
  final String filterStatus;

  const BookingList({
    super.key,
    required this.bookings,
    required this.filterStatus,
  });

  @override
  Widget build(BuildContext context) {
    final filtered =
        bookings
            .where(
              (booking) =>
                  (booking["status"] ?? "").toLowerCase() == filterStatus,
            )
            .toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Text(
          "No bookings with this status",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return BookingCard(booking: filtered[index]);
      },
    );
  }
}
