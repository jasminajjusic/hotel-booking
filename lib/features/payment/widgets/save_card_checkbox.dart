import 'package:flutter/material.dart';

class SaveCardCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SaveCardCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: value ? const Color(0xFF165244) : Colors.white,
              border: Border.all(color: const Color(0xFFBDBDBD), width: 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
            child:
                value
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
          ),
          const SizedBox(width: 12),
          const Text(
            "Save card info for future",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
