import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_state.dart';

class BookingButton extends StatelessWidget {
  final BookingState state;
  final TextEditingController checkInController;
  final TextEditingController checkOutController;
  final String userId;
  final String hotelId;
  final ValueNotifier<String?> roomType;

  const BookingButton({
    super.key,
    required this.state,
    required this.checkInController,
    required this.checkOutController,
    required this.userId,
    required this.hotelId,
    required this.roomType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF165244),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed:
            state.loading
                ? null
                : () {
                  final checkIn = DateTime.tryParse(checkInController.text);
                  final checkOut = DateTime.tryParse(checkOutController.text);

                  if (checkIn == null || checkOut == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid dates")),
                    );
                    return;
                  }

                  context.read<BookingCubit>().createBooking(
                    userId: userId,
                    hotelId: hotelId,
                    checkIn: checkIn,
                    checkOut: checkOut,
                  );

                  if (roomType.value != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Room type: ${roomType.value}")),
                    );
                  }
                },
        child:
            state.loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }
}
