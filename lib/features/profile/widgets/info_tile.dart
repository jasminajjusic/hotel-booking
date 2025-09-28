import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const InfoTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(232, 232, 232, 1), width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromRGBO(27, 27, 27, 1),
            fontFamily: 'SFPro',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Color.fromRGBO(68, 67, 67, 1),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFPro',
            height: 2,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, size: 26),
        onTap: onTap,
      ),
    );
  }
}
