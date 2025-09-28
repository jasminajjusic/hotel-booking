import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;

  const ProfileAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : 'U';

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Wrap(
                children: [
                  const Center(
                    child: Text(
                      "Update Profile Picture",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF165244),
                      ),
                    ),
                  ),
                  const Divider(height: 24),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Take a Photo"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF165244),
            child: Text(
              firstLetter,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFPro',
              ),
            ),
          ),
          const SizedBox(width: 24),
          const Expanded(
            child: Text(
              'JPEG, PNG up to 5MB',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
