import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/views/tenant/tenant_details_page.dart';
import 'package:security/views/tenant/add_guest.dart';
import 'package:security/views/tenant/visitors_page.dart';
import 'package:security/controllers/tenant_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TenantController controller = Get.put(TenantController());
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const TenantPage(),
    const AddGuest(),
    const VisitorsPage(),
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
              opacity: 1,
              child: Image.asset(
                'lib/assets/images/logo-blue.png',
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
      bottomNavigationBar: Stack(
        children: [
          WaterDropNavBar(
            backgroundColor: CustomColors.accentColor,
            waterDropColor: CustomColors.iconColor,
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
                filledIcon: Icons.notifications,
                outlinedIcon: Icons.notifications_outlined,
              ),
            ],
            bottomPadding: 10,
            iconSize: 30,
          ),
          Obx(() {
            final visitorCount = controller.visitors.length;
            if (visitorCount == 0) return const SizedBox.shrink();

            return Positioned(
              bottom: 22, // Adjust the position to match the icon's location
              right: MediaQuery.of(context).size.width * 0.11, // Fine-tune the position
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$visitorCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}