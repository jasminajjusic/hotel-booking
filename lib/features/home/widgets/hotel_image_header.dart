import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelbooking/features/home/cubit/hotel_model.dart';
import 'package:hotelbooking/features/home/cubit/hotel_cubit.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';

class HotelImageHeader extends HookWidget {
  final Hotel hotel;
  final double imageHeight;

  const HotelImageHeader({
    super.key,
    required this.hotel,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = useState<bool>(hotel.favorite);

    void toggleFavorite() {
      isFavorite.value = !isFavorite.value;

      context.read<HotelCubit>().toggleFavorite(hotel.id, isFavorite.value);
    }

    return SizedBox(
      height: imageHeight,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.network(
              hotel.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: imageHeight,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
            ),
          ),

          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.go(AppRoutes.home),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/left_arrow.svg',
                            width: 18,
                            height: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: toggleFavorite,
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            isFavorite.value
                                ? 'assets/icons/favorite.svg'
                                : 'assets/icons/heart.svg',
                            width: 18,
                            height: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
