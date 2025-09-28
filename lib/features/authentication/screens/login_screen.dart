import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelbooking/features/authentication/cubit/auth_cubit.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => AuthCubit(Supabase.instance.client),
      child: BlocConsumer<AuthCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go(AppRoutes.home);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF4F6F6),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildBackArrow(context, AppRoutes.onboarding),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Login to your account',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    _buildLabelledTextField(
                      'Email',
                      'Enter your email',
                      emailController,
                    ),
                    const SizedBox(height: 20),
                    _buildLabelledTextField(
                      'Password',
                      'Enter your password',
                      passwordController,
                      obscure: true,
                    ),
                    const SizedBox(height: 40),
                    _buildLoginButton(
                      context,
                      state,
                      emailController,
                      passwordController,
                    ),
                    const SizedBox(height: 20),
                    _buildSignUpRow(context),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialLoginBox(
                          'assets/icons/google.svg',
                          () => context.read<AuthCubit>().loginWithGoogle(),
                        ),
                        _buildSocialLoginBox('assets/icons/apple.svg', () {}),
                        _buildSocialLoginBox(
                          'assets/icons/facebook.svg',
                          () => context.read<AuthCubit>().loginWithFacebook(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackArrow(BuildContext context, String route) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 0.5),
          ),
          child: SvgPicture.asset(
            'assets/icons/left_arrow.svg',
            height: 20,
            width: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildLabelledTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD1D7), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD1D7), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF165244),
                width: 0.5,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    AuthenticationState state,
    TextEditingController email,
    TextEditingController password,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed:
            state is AuthLoading
                ? null
                : () {
                  context.read<AuthCubit>().login(
                    email.text.trim(),
                    password.text.trim(),
                  );
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF165244),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:
            state is AuthLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
      ),
    );
  }

  Widget _buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don’t have an account?'),
        TextButton(
          onPressed: () => context.go(AppRoutes.register),
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Color(0xFF165244)),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginBox(String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCBD1D7), width: 0.5),
        ),
        child: Center(child: SvgPicture.asset(iconPath, height: 24, width: 24)),
      ),
    );
  }
}
