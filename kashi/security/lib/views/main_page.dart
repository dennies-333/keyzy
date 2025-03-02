import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/views/tenant/tenant_view.dart';
import 'package:security/views/tenant/add_guest.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const TenantPage(),
    const AddGuest(),
    const PlaceholderWidget('Vehicles'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Stack(
        children: [
          // Watermark logo
          Center(
            child: Opacity(
              opacity: 1, // Adjust opacity for subtle effect
              child: Image.asset(
                'lib/assets/images/logo-brown.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Page content
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _pages,
          ),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: CustomColors.accentColor,
        waterDropColor: CustomColors.background,
        onItemSelected: _onItemTapped,
        selectedIndex: _currentIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.person_rounded,
            outlinedIcon: Icons.person_outline,
          ),
          BarItem(
            filledIcon: Icons.people_rounded,
            outlinedIcon: Icons.people_outline,
          ),
          BarItem(
            filledIcon: Icons.directions_car_rounded,
            outlinedIcon: Icons.directions_car_outlined,
          ),
        ],
        bottomPadding: 10,
        iconSize: 30,
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
