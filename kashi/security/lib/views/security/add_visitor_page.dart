import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/controllers/security_controller.dart';
import 'package:security/controllers/auth_controller.dart';

class RegisterVisitor extends StatelessWidget {
  final SecurityController controller = Get.find();
  final AuthController authController = Get.find();
  RegisterVisitor({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        authController.logout();
        return false;
      },
    child: SafeArea(
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Card(
                color: CustomColors.accentColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Register New Visitor",
                        style: TextStyle(
                          fontFamily: "Satoshi",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Fill in the visitor details below",
                        style: TextStyle(
                          fontFamily: "Satoshi",
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1, height: 24),


                      _buildSectionTitle(Icons.person, "Visitor Details"),
                      const SizedBox(height: 20),

                      _buildSectionTitle(null, "Visitor Name"),
                      const SizedBox(height: 2),
                      _buildInputField(
                        controller: controller.visitorNameController,
                        hintText: "Enter Visitor's Name",
                      ),
                      const SizedBox(height: 24),

                      _buildSectionTitle(null, "Visitor Type"),
                      const SizedBox(height: 2),
                      _buildDropdownField(),
                      const SizedBox(height: 24),

                      _buildSectionTitle(null, "Purpose of Visit"),
                      const SizedBox(height: 2),
                      _buildInputField(
                        controller: controller.purposeController,
                        hintText: "Enter Purpose of Visit",
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1, height: 24),


                      _buildSectionTitle(Icons.apartment, "Tenant Information"),
                      const SizedBox(height: 20),

                      _buildSectionTitle(null, "Select Tenant"),
                      const SizedBox(height: 2),
                      _buildTenantSelector(context),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.registerVisitor();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.iconColor,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Register Visitor',
                            style: TextStyle(
                              fontFamily: "Satoshi",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    ),
    );
  }

  Widget _buildSectionTitle(IconData? icon, String title) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: CustomColors.iconColor),
          const SizedBox(width: 10),
        ],
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Satoshi",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: "Satoshi",
          fontSize: 16,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CustomColors.iconColor),
        ),
      ),
    );
  }

Widget _buildDropdownField() {
  return Obx(
    () => Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        color: CustomColors.accentColor, // Background color
        borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.visitorType.value,
          isExpanded: true,
          dropdownColor: CustomColors.accentColor, // Dropdown menu color
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.visitorType.value = newValue;
            }
          },
          items: controller.visitorTypes.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type,
                style: const TextStyle(
                  fontFamily: "Satoshi",
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}


Widget _buildTenantSelector(BuildContext context) {
  return Obx(
    () => GestureDetector(
      onTap: () => _showTenantBottomSheet(context),
      child: Container(
        height: 56, // Matching input box height
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          controller.selectedTenant.value?.name ?? "Select a tenant",
          style: const TextStyle(
            fontFamily: "Satoshi",
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

void _showTenantBottomSheet(BuildContext context) {
  controller.searchQuery.value = ''; // Reset search when opening
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(
        () {
          final filteredTenants = controller.tenants.where((tenant) {
            final query = controller.searchQuery.value.toLowerCase();
            return tenant.name.toLowerCase().contains(query) ||
                   tenant.id.toLowerCase().contains(query);
          }).toList();

          return Column(
            mainAxisSize: MainAxisSize.min, // Keeps bottom sheet compact
            children: [
              // Search Bar
              TextField(
                onChanged: (value) => controller.searchQuery.value = value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search by name or ID...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.iconColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Tenant List
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredTenants.length,
                  itemBuilder: (context, index) {
                    final tenant = filteredTenants[index];
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5),
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          tenant.name,
                          style: const TextStyle(
                            fontFamily: "Satoshi",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "Apartment: ${tenant.unitNumber}",
                          style: const TextStyle(
                            fontFamily: "Satoshi",
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          controller.selectedTenant.value = tenant;
                          Get.back(); // Close bottom sheet
                        },
                      ),
                    );
                  },
                ),
              ),


              const SizedBox(height: 20),

              // Cancel Button
              Container(
                color: CustomColors.iconColor, // Highlighted background color
                child: ListTile(
                  title: const Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: "Satoshi",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                  ),
                  onTap: () => Get.back(), // Close the bottom sheet
                ),
              ),
            ],
          );
        },
      ),
    ),
    isScrollControlled: false, // Keeps sheet small
  );
}



}
