import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Text(
              "Date & preferences",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
          ),

          Positioned(
            left: -16,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/left_arrow.svg',
                width: 24,
                height: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
