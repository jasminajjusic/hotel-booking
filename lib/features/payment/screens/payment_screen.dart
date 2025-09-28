import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';
import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';
import '../widgets/payment_success_dialog.dart';
import '../widgets/save_card_checkbox.dart';
import '../widgets/payment_text_field.dart';

class PaymentScreen extends HookWidget {
  final String bookingId;
  final double amount;

  const PaymentScreen({Key? key, required this.bookingId, required this.amount})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardNumber = useTextEditingController();
    final cardHolder = useTextEditingController();
    final expiryDate = useTextEditingController();
    final cvv = useTextEditingController();
    final saveCard = useState(false);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.go(AppRoutes.appointments);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/left_arrow.svg',
              width: 16,
              height: 8,
              color: Colors.black87,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey, height: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentTextField(
              controller: cardHolder,
              label: "Card Holder Name",
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            PaymentTextField(
              controller: cardNumber,
              label: "Card Number",
              icon: Icons.credit_card,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            PaymentTextField(
              controller: expiryDate,
              label: "Expiry Date (MM/YY)",
              icon: Icons.date_range,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            PaymentTextField(
              controller: cvv,
              label: "CVV",
              icon: Icons.lock,
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SaveCardCheckbox(
              value: saveCard.value,
              onChanged: (val) => saveCard.value = val,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final cubit = context.read<BookingCubit>();
                  await cubit.payBooking(bookingId);

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => PaymentSuccessDialog(
                          onConfirm: () {
                            context.go(AppRoutes.appointments);
                          },
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF165244),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
