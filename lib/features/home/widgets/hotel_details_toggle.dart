import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HotelDetailsToggle extends HookWidget {
  final ValueNotifier<bool> showInfo;

  const HotelDetailsToggle({super.key, required this.showInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F8F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => showInfo.value = true,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        showInfo.value
                            ? const Color(0xFF165244)
                            : const Color(0xFFF5F8F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Info",
                    style: TextStyle(
                      color: showInfo.value ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => showInfo.value = false,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        showInfo.value
                            ? const Color(0xFFF5F8F9)
                            : const Color(0xFF165244),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Ratings",
                    style: TextStyle(
                      color: showInfo.value ? Colors.black87 : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
