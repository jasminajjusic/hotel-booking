import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFAFDFF),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Profile',
        style: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          'assets/icons/left_arrow.svg',
          height: 24,
          width: 24,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 24,
              width: 24,
            ),
          ),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(color: Color(0xFFDFE8F6), height: 0.5),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
