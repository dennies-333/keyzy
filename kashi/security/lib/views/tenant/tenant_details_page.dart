import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/controllers/tenant_controller.dart';
import 'package:security/controllers/auth_controller.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/models/tenant_model.dart';

class TenantPage extends StatelessWidget {
  const TenantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TenantController tenantController = Get.find();
    final AuthController authController = Get.put(AuthController());
    
    return WillPopScope(
    onWillPop: () async {
      authController.logout();
      return false;
    },
    child: SafeArea(
    child:  Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Fixed header section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Reduced vertical padding
            color: Colors.transparent,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: CustomColors.iconColor),
                  onPressed: () async => await authController.logout(),
                ),
                const SizedBox(width: 10),
                Obx(() {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7, // Adjust width as needed
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome back, ",
                            style: TextStyle(
                              fontFamily: "Satoshi",
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.textColor, // "Welcome back" in white
                            ),
                          ),
                          TextSpan(
                            text: "${tenantController.tenantName.value}!",
                            style: TextStyle(
                              fontFamily: "Satoshi",
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.iconColor, // Tenant's name in custom color
                            ),
                          ),
                        ],
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  );
                }),
              ],
            ),
          ),


          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTenantInfo(tenantController),
                    const SizedBox(height: 20),
                    _buildExpandableCard(
                      title: "Family Members",
                      count: tenantController.familyMembers.length,
                      icon: Icons.family_restroom,
                      content: _buildFamilyMembersList(tenantController.familyMembers),
                    ),

                    const SizedBox(height: 20),

                    _buildExpandableCard(
                      title: "Registered Vehicles",
                      count: tenantController.vehicles.length,
                      icon: Icons.directions_car,
                      content: _buildVehiclesList(tenantController.vehicles),
                    ),

                  ],
                );
              }),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }

  // Tenant profile card
  Widget _buildTenantInfo(TenantController controller) {
    return Card(
      color: CustomColors.accentColor,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: CustomColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person_outline,
                size: 40,
                color: CustomColors.iconColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Profile Details",
              style: TextStyle(
                fontFamily: "Satoshi",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: CustomColors.iconColor,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileItem(
              icon: Icons.person_outline,
              label: "Name",
              value: controller.tenantName.value,
            ),
            _buildProfileItem(
              icon: Icons.email_outlined,
              label: "Email",
              value: controller.tenantEmail.value,
            ),
            _buildProfileItem(
              icon: Icons.shield_outlined,
              label: "Role",
              value: controller.tenantRole.value,
            ),
            _buildProfileItem(
              icon: Icons.apartment_outlined,
              label: "Unit",
              value: controller.tenantUnitNumber.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 30, color: CustomColors.iconColor),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:TextStyle(
                    fontFamily: "Satoshi",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.iconColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: "Satoshi",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableCard({
  required String title,
  required int count,
  required IconData icon,
  required Widget content,
}) {
  final isExpanded = false.obs;
  
  return Obx(() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: CustomColors.accentColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  // Icon container
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: CustomColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 40, color: CustomColors.iconColor),
                  ),
                  const SizedBox(width: 20),
                  
                  // Title and count
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: "Satoshi",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.iconColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "$count",
                          style: TextStyle(
                            fontFamily: "Satoshi",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Expand/collapse arrow
                  IconButton(
                    icon: Icon(
                      isExpanded.value ? Icons.expand_less : Icons.expand_more,
                      color: CustomColors.iconColor,
                    ),
                    onPressed: () => isExpanded.toggle(),
                  ),
                ],
              ),
              if (isExpanded.value) const SizedBox(height: 20),
              if (isExpanded.value) content,
            ],
          ),
        ),
      ));
}

Widget _buildFamilyMembersList(List<FamilyMember> members) {
  if (members.isEmpty) {
    return _buildEmptyState("No family members found.");
  }
  return Column(
    children: members.map((member) {
      return Card(
        color: CustomColors.background,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // Icon container
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: CustomColors.accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.family_restroom, size: 30, color: CustomColors.iconColor),
              ),
              const SizedBox(width: 20),

              // Member details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member.firstName} ${member.lastName}",
                      style: TextStyle(
                        fontFamily: "Satoshi",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.iconColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Relationship: ${member.relationship}",
                      style:TextStyle(
                        fontFamily: "Satoshi",
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildVehiclesList(List<Vehicle> vehicles) {
  if (vehicles.isEmpty) {
    return _buildEmptyState("No vehicles registered.");
  }
  return Column(
    children: vehicles.map((vehicle) {
      return Card(
        color: CustomColors.background,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // Icon container
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: CustomColors.accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.directions_car, size: 30, color: CustomColors.iconColor),
              ),
              const SizedBox(width: 20),

              // Vehicle details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.vehicleName,
                      style: TextStyle(
                        fontFamily: "Satoshi",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.iconColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Type: ${vehicle.vehicleType} • No: ${vehicle.vehicleNumber}",
                      style:TextStyle(
                        fontFamily: "Satoshi",
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

// A simple reusable empty state widget
Widget _buildEmptyState(String message) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Text(
        message,
        style: TextStyle(
          fontFamily: "Satoshi",
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
}
