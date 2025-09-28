import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/hotel_cubit.dart';

class HotelCard extends StatefulWidget {
  final String hotelId;
  final String imagePath;
  final String title;
  final String price;
  final String location;
  final String rating;
  final bool isFavorite;
  final VoidCallback onTap;

  const HotelCard({
    super.key,
    required this.hotelId,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.location,
    required this.rating,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    context.read<HotelCubit>().toggleFavorite(widget.hotelId, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = widget.imagePath.startsWith('http');

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 230,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  isNetworkImage
                      ? Image.network(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        height: 230,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            height: 230,
                            width: double.infinity,
                            child: const Icon(Icons.broken_image, size: 50),
                          );
                        },
                      )
                      : Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        height: 230,
                        width: double.infinity,
                      ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.price,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            height: 16,
                            width: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.location,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/star1.svg',
                            height: 16,
                            width: 16,
                            color: Colors.deepOrangeAccent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.rating,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      isFavorite
                          ? 'assets/icons/favorite.svg'
                          : 'assets/icons/heart.svg',
                      height: 18,
                      width: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
