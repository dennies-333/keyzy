import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/controllers/tenant_controller.dart';
import 'package:security/controllers/auth_controller.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/components/animated_card.dart';

class VisitorsPage extends StatelessWidget {
  const VisitorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TenantController controller = Get.find();
    final AuthController authController = Get.find();



  return WillPopScope(
  onWillPop: () async {
    authController.logout();
    return false;
  },
    child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: CustomColors.iconColor),
                    onPressed: () => authController.logout(),
                  ),
                  Text(
                    'Visitors',
                    style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.iconColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Visitors List
              Expanded(
                child: GetBuilder<TenantController>(
                  builder: (controller) {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.visitors.isEmpty) {
                      return Center(
                        child: Text(
                          'No visitors yet.',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: controller.visitors.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final visitor = controller.visitors[index];
                        return AnimatedCard(
                          key: ValueKey(visitor.visitorId),
                          icon: Icons.person_outline,
                          title: visitor.name,
                          children: [
                            _buildInfoRow("Relationship:", visitor.relationship),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildActionButton(
                                  icon: Icons.check,
                                  color: Colors.green,
                                  onPressed: () async => await controller.updateVisitor(visitor.visitorId),
                                ),
                                _buildActionButton(
                                  icon: Icons.close,
                                  color: Colors.red,
                                  onPressed: () => controller.updateVisitor(visitor.visitorId),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
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

  // Info row
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.raleway(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Action buttons (accept/decline)
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}
