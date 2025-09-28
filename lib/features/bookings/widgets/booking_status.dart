import 'package:flutter/material.dart';

class BookingStatus extends StatelessWidget {
  final Map booking;

  const BookingStatus({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (booking["status"]) {
      case "confirmed":
        statusColor = Colors.green;
        statusIcon = Icons.check;
        break;
      case "cancelled":
        statusColor = Colors.red;
        statusIcon = Icons.close;
        break;
      case "pending":
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            booking["hotel_name"] ?? "Unknown Hotel",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(statusIcon, color: statusColor, size: 20),
        ),
      ],
    );
  }
}
