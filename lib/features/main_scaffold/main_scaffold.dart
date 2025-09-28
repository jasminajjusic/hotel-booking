import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelbooking/features/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getSelectedIndex(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(children: [Expanded(child: child)]),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 69,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFDFE8F6), width: 0.5),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => _onItemTapped(context, index),
              backgroundColor: Colors.transparent,
              unselectedItemColor: Colors.grey,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontSize: 12, height: 1.2),
              unselectedLabelStyle: const TextStyle(fontSize: 12, height: 1.2),
              iconSize: 20,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _customIconWithLabel(
                    'assets/icons/home2.svg',
                    currentIndex == 0,
                    'assets/icons/home2.svg',
                    'Home',
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _customIconWithLabel(
                    'assets/icons/search2.svg',
                    currentIndex == 1,
                    'assets/icons/search2.svg',
                    'Search',
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _customIconWithLabel(
                    'assets/icons/booking.svg',
                    currentIndex == 2,
                    'assets/icons/booking.svg',
                    'Bookings',
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _customIconWithLabel(
                    'assets/icons/profile.svg',
                    currentIndex == 3,
                    'assets/icons/profile.svg',
                    'Profile',
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final state = GoRouter.of(context).routerDelegate.currentConfiguration;

    if (state.uri.path.startsWith(AppRoutes.home) == true) return 0;
    if (state.uri.path.startsWith(AppRoutes.search) == true) return 1;
    if (state.uri.path.startsWith(AppRoutes.appointments) == true) return 2;
    if (state.uri.path.startsWith(AppRoutes.profile) == true) return 3;

    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/appointments');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  Widget _customIconWithLabel(
    String assetPath,
    bool isSelected,
    String? selectedAssetPath,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        SvgPicture.asset(
          isSelected && selectedAssetPath != null
              ? selectedAssetPath
              : assetPath,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            isSelected ? const Color(0xFF165244) : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 0,
            color: isSelected ? const Color(0xFF165244) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
