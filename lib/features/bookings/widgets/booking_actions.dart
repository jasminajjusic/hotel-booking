import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';

class BookingActions extends StatelessWidget {
  final Map booking;

  const BookingActions({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final status = booking["status"] as String;

    if (status == "cancelled") return const SizedBox.shrink();

    return Row(
      children: [
        if (status != "confirmed")
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.go(
                  '${AppRoutes.payment}/${booking["id"]}/${booking["total_price"]}',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF165244),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Pay",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (status != "confirmed") const SizedBox(width: 12),

        Expanded(
          child: OutlinedButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder:
                    (ctx) => Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              size: 48,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Cancel Booking",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Are you sure you want to cancel this booking?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed:
                                        () => Navigator.of(ctx).pop(false),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      "No",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed:
                                        () => Navigator.of(ctx).pop(true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              );

              if (confirm == true) {
                final cubit = context.read<BookingCubit>();
                await cubit.deleteBooking(booking["id"]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Booking cancelled successfully"),
                  ),
                );
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Color(0xFF165244)),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF165244),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
