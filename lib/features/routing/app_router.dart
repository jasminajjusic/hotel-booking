import 'package:go_router/go_router.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';
import 'package:hotelbooking/features/onboarding/screens/onboarding_screen.dart';
import 'package:hotelbooking/features/home/screens/home_screen.dart';
import 'package:hotelbooking/features/home/screens/hotel_details_screen.dart';
import 'package:hotelbooking/features/search/screens/search_screen.dart';
import 'package:hotelbooking/features/bookings/screens/bookings_screen.dart';
import 'package:hotelbooking/features/profile/screens/profile_screen.dart';
import 'package:hotelbooking/features/main_scaffold/main_scaffold.dart';
import 'package:hotelbooking/features/authentication/screens/login_screen.dart';
import 'package:hotelbooking/features/authentication/screens/register_screen.dart';
import 'package:hotelbooking/features/payment/screens/payment_screen.dart';
import 'package:hotelbooking/features/home/cubit/hotel_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotelbooking/features/bookings/cubit/booking_cubit.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: AppRoutes.appointments,
          builder: (context, state) {
            return const BookingsScreen();
          },
        ),

        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.hotelDetails,
      name: 'hotel-details',
      builder: (context, state) {
        final hotel = state.extra as Hotel;
        return HotelDetailsScreen(hotel: hotel);
      },
    ),
    GoRoute(
      path: '${AppRoutes.payment}/:bookingId/:amount',
      builder: (context, state) {
        final bookingId = state.pathParameters['bookingId']!;
        final amount = double.parse(state.pathParameters['amount']!);

        return BlocProvider(
          create: (_) => BookingCubit(Supabase.instance.client),
          child: PaymentScreen(bookingId: bookingId, amount: amount),
        );
      },
    ),
  ],
);
