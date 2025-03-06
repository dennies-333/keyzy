import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:security/utils/custom_colors.dart';
import 'security_details_page.dart';
import 'package:security/views/tenant/add_guest.dart';
import 'package:security/views/tenant/visitors_page.dart';
import 'package:security/controllers/tenant_controller.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final TenantController controller = Get.put(TenantController());
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const SecurityDetailView(),
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
              opacity: 0.1,
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CustomColors.background, // Match navigation bar to background color
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: CustomColors.iconColor,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: CustomColors.accentColor,
            color: Colors.black,
            selectedIndex: _currentIndex,
            onTabChange: _onItemTapped,
            tabs: [
              // User Profile tab
              const GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
              ),

              // Add Guest tab
              const GButton(
                icon: Icons.person_add,
                text: 'Add Guest',
              ),

              // Add Guest with Badge
              GButton(
                icon: Icons.person_add,
                text: 'Notifications',
                leading: Obx(() {
                  final guestCount = controller.visitors.length;
                  if (guestCount == 0) return const Icon(Icons.person_add);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.person_add),
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$guestCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      )

    );
  }
}
