import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_state.dart';
import 'package:hotelbooking/features/home/widgets/booking_header.dart';
import 'package:hotelbooking/features/home/widgets/booking_input_fields.dart';
import 'package:hotelbooking/features/home/widgets/booking_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/config.dart';

class HotelBookingForm extends HookWidget {
  final String userId;
  final String hotelId;

  const HotelBookingForm({
    super.key,
    required this.userId,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    final checkInController = useTextEditingController();
    final checkOutController = useTextEditingController();

    final roomType = useState<String?>(null);

    final supabase = SupabaseClient(
      AppConfig.supabaseUrl,
      AppConfig.supabaseAnonKey,
    );

    return BlocProvider(
      create: (_) => BookingCubit(supabase),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Booking successful!")),
            );
            Navigator.pop(context);
          } else if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.error}")));
          }
        },
        builder: (context, state) {
          return Container(
            color: const Color.fromARGB(255, 251, 251, 253),
            padding: MediaQuery.of(
              context,
            ).viewInsets.add(const EdgeInsets.all(16)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BookingHeader(),
                  const SizedBox(height: 24),
                  BookingInputFields(
                    checkInController: checkInController,
                    checkOutController: checkOutController,

                    roomType: roomType,
                  ),
                  const SizedBox(height: 24),
                  BookingButton(
                    state: state,
                    checkInController: checkInController,
                    checkOutController: checkOutController,
                    userId: userId,
                    hotelId: hotelId,
                    roomType: roomType,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
