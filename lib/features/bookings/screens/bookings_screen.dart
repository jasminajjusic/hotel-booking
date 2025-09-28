import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_state.dart';
import 'package:hotelbooking/features/bookings/widgets/booking_list.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';

class BookingsScreen extends HookWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final selectedStatus = useState("pending");

    return BlocProvider(
      create: (_) => BookingCubit(supabase)..fetchUserBookings(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                'Bookings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  'assets/icons/left_arrow.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusBox(context, "Pending", "pending", selectedStatus),
                  _statusBox(context, "Confirmed", "confirmed", selectedStatus),
                  _statusBox(context, "Cancelled", "cancelled", selectedStatus),
                ],
              ),
            ),

            Expanded(
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.bookings.isEmpty) {
                    return _buildEmptyBookings(context);
                  }

                  return BookingList(
                    bookings: state.bookings,
                    filterStatus: selectedStatus.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBox(
    BuildContext context,
    String label,
    String status,
    ValueNotifier<String> selectedStatus,
  ) {
    final isSelected = selectedStatus.value == status;
    return GestureDetector(
      onTap: () {
        selectedStatus.value = status;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF165244) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF165244) : Colors.grey.shade300,
          ),
          boxShadow:
              isSelected
                  ? [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyBookings(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/appointments.svg',
            width: 100,
            height: 100,
            color: Colors.black54,
          ),
          const SizedBox(height: 16),
          const Text(
            'No bookings yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go(AppRoutes.search);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF165244),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Search Hotels",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
