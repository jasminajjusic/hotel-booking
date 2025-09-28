import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelbooking/features/profile/cubit/profile_cubit.dart';
import 'package:hotelbooking/features/home/widgets/hotel_card.dart';
import '../cubit/hotel_cubit.dart';
import '../cubit/hotel_state.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';
import 'package:hotelbooking/features/profile/data/models/profile_model.dart';
import 'package:hotelbooking/features/home/widgets/search_bar.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ["All", "Popular", "Luxury", "Budget", "Family"];
    final selectedIndex = useState(0);
    final searchController = useTextEditingController();

    useEffect(() {
      void listener() {
        context.read<HotelCubit>().fetchHotels(
          searchQuery: searchController.text,
        );
      }

      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HotelCubit(Supabase.instance.client)..fetchHotels(),
        ),
        BlocProvider(create: (_) => ProfileCubit()..loadProfile()),
      ],
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 251, 253),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProfileCubit, Profile>(
                  builder: (context, profile) {
                    final name =
                        profile.name.isNotEmpty ? profile.name : "User";
                    final firstLetter = name.isNotEmpty ? name[0] : "U";

                    return Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF165244),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              firstLetter,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Hi, $name',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                            const Text(
                              'How are you today?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF171717),
                                height: 1.0,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/icons/notifications.svg',
                          height: 24,
                          width: 24,
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                CustomSearchBar(controller: searchController),

                const SizedBox(height: 20),

                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final isSelected = index == selectedIndex.value;
                      return GestureDetector(
                        onTap: () => selectedIndex.value = index,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color(0xFF165244)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: BlocBuilder<HotelCubit, HotelState>(
                    builder: (context, state) {
                      if (state is HotelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HotelLoaded) {
                        final hotels = state.hotels;
                        if (hotels.isEmpty) {
                          return const Center(child: Text('No hotels found'));
                        }

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: hotels.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final hotel = hotels[index];

                            return HotelCard(
                              hotelId: hotel.id,
                              imagePath: hotel.imageUrl,
                              title: hotel.name,
                              price: '£${hotel.price.toStringAsFixed(0)}/night',
                              location: hotel.location,
                              rating: hotel.rating.toStringAsFixed(1),
                              isFavorite: hotel.favorite,
                              onTap: () {
                                context.push(
                                  AppRoutes.hotelDetails,
                                  extra: hotel,
                                );
                              },
                            );
                          },
                        );
                      } else if (state is HotelError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
