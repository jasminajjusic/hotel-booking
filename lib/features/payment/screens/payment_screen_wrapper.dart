import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';
import 'payment_screen.dart';

class PaymentScreenWrapper extends StatelessWidget {
  final String bookingId;
  final double amount;

  const PaymentScreenWrapper({
    Key? key,
    required this.bookingId,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(Supabase.instance.client),
      child: PaymentScreen(bookingId: bookingId, amount: amount),
    );
  }
}
