import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HotelAmenities extends StatelessWidget {
  const HotelAmenities({super.key});

  Widget _buildIconCircle(String iconPath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF5F8F9),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildIconCircle('assets/icons/wifi.svg', 'Wi-Fi'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/pool.svg', 'Pool'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/parking.svg', 'Parking'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/caffe.svg', 'Caffe'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/gym.svg', 'Gym'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/garden.svg', 'Garden'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/spa.svg', 'Spa'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/restaurant.svg', 'Restaurant'),
          const SizedBox(width: 12),
          _buildIconCircle('assets/icons/bar.svg', 'Bar'),
        ],
      ),
    );
  }
}
