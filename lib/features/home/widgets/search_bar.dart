import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const CustomSearchBar({super.key, this.controller, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 44,
        padding: const EdgeInsets.only(left: 16, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDFE8F6), width: 0.5),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/search2.svg',
              width: 20,
              height: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Search destinations',
                  border: InputBorder.none,
                ),
                onSubmitted: onSubmitted,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: Color(0xFFF86F03),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
