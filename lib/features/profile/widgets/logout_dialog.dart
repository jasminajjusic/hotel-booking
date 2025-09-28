import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hotelbooking/features/authentication/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';

class LogoutDialog extends StatelessWidget {
  final AuthCubit authCubit;
  const LogoutDialog({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE1E1E1)),
            ),
            title: const Padding(
              padding: EdgeInsets.only(top: 12, bottom: 4),
              child: Text(
                'Log Out',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 6),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Are you sure you want to log out?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      authCubit.logout();
                      Navigator.of(context).pop();
                      context.go(AppRoutes.login);
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: const [],
          ),
        ),
      ],
    );
  }
}
