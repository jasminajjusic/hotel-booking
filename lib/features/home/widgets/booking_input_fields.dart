import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hotelbooking/features/home/widgets/booking_calendar.dart';

class BookingInputFields extends HookWidget {
  final TextEditingController checkInController;
  final TextEditingController checkOutController;
  final ValueNotifier<String?> roomType;

  const BookingInputFields({
    super.key,
    required this.checkInController,
    required this.checkOutController,
    required this.roomType,
  });

  @override
  Widget build(BuildContext context) {
    final selectedGuests = useState<int?>(null);
    final showCheckOut = useState<bool>(false);

    List<int> guestOptions = [1, 2, 3, 4, 5];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          child:
              showCheckOut.value
                  ? Column(
                    key: const ValueKey("checkOut"),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check-out Date",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      BookingCalendar(
                        onDateSelected: (date) {
                          checkOutController.text =
                              date.toIso8601String().split('T').first;
                        },
                      ),
                    ],
                  )
                  : Column(
                    key: const ValueKey("checkIn"),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check-in Date",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      BookingCalendar(
                        onDateSelected: (date) {
                          checkInController.text =
                              date.toIso8601String().split('T').first;
                          showCheckOut.value = true;
                        },
                      ),
                    ],
                  ),
        ),

        const SizedBox(height: 24),

        const Text(
          "Number of Guests",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                guestOptions.map((guest) {
                  final isSelected = selectedGuests.value == guest;
                  return GestureDetector(
                    onTap: () => selectedGuests.value = guest,
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? Color(0xFF165244) : Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        guest.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownColor: Colors.white,
          value: roomType.value,
          hint: const Text(
            "Select room type",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          items:
              [
                "Suite",
                "Deluxe",
                "Single",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => roomType.value = value,
        ),
      ],
    );
  }
}
