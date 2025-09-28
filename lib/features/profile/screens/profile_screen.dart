import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelbooking/features/profile/widgets/profile_avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/features/profile/cubit/profile_cubit.dart';
import 'package:hotelbooking/features/authentication/cubit/auth_cubit.dart';
import 'package:hotelbooking/features/profile/widgets/profile_app_bar.dart';
import 'package:hotelbooking/features/profile/widgets/profile_section.dart';
import 'package:hotelbooking/features/profile/widgets/logout_dialog.dart';
import 'package:hotelbooking/features/profile/data/models/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(supabase)),
        BlocProvider(
          create: (_) {
            final cubit = ProfileCubit();
            cubit.loadProfile();
            return cubit;
          },
        ),
      ],
      child: _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends HookWidget {
  _ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFDFF),
      appBar: const ProfileAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                BlocBuilder<ProfileCubit, Profile?>(
                  builder: (context, profile) {
                    final displayName =
                        profile?.name.isNotEmpty == true
                            ? profile!.name
                            : "User";
                    return ProfileAvatar(name: displayName);
                  },
                ),

                const SizedBox(height: 24),
                const ProfileSection(),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () {
                    final authCubit = context.read<AuthCubit>();
                    showDialog(
                      context: context,
                      builder: (_) => LogoutDialog(authCubit: authCubit),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
