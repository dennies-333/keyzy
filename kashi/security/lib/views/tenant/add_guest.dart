import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/controllers/tenant_controller.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/controllers/auth_controller.dart';
import 'package:security/components/animated_card.dart';

class AddGuest extends StatelessWidget {
  const AddGuest({super.key});

  @override
  Widget build(BuildContext context) {
    final TenantController tenantController = Get.find();
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),  // Reduced bottom padding

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: CustomColors.iconColor),
                        onPressed: () async => await authController.logout(),
                      ),
                      Text(
                        'Add Guest',
                        style: GoogleFonts.raleway(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.iconColor,  // Title color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Personal Details Card
                  AnimatedCard(
                    icon: Icons.person,
                    title: "Personal Details",
                    children: [
                      _buildInputField(
                        controller: tenantController.guestName,
                        hintText: "Enter Name",
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),

                  // Vehicle Information Card
                  AnimatedCard(
                    icon: Icons.directions_car,
                    title: "Vehicle Information",
                    children: [
                      _buildInputField(
                        controller: tenantController.guestVehicleType,
                        hintText: "Enter Vehicle Type",
                      ),
                      const SizedBox(height: 10),
                      _buildInputField(
                        controller: tenantController.guestVehicleNUmber,
                        hintText: "Enter Vehicle Number",
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),

                  // Visit Schedule Card
                  AnimatedCard(
                    icon: Icons.calendar_today,
                    title: "Visit Schedule",
                    children: [
                      GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomColors.accentColor,
                                  onPrimary: Colors.white,
                                  onSurface: CustomColors.iconColor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomColors.accentColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                          tenantController.guestDay.text = formattedDate;
                        }
                      },


                        child: AbsorbPointer(
                          child: _buildInputField(
                            controller: tenantController.guestDay,
                            hintText: "Select Date",
                            icon: Icon(Icons.calendar_today, color: CustomColors.iconColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  
                  const SizedBox(height: 30),

                  // Submit Button
                  SizedBox(
                  width: double.infinity,  // Makes the button width the same as the cards
                  child: ElevatedButton(
                    onPressed: () async{
                      await tenantController.addGuest();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.iconColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Set a smaller value for less rounding
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,  // Centers the icon and text
                      children: [
                        CircleAvatar(
                          radius: 18,  // Adjusts the size of the circle
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.check,  // Tick icon
                            color: CustomColors.accentColor,
                          ),
                        ),
                        const SizedBox(width: 10),  // Space between the icon and the text
                        Text(
                          'Complete Registration',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,  // White text color
                          ),
                        ),
                      ],
                    ),
                  ),
                )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom Card Widget
  Widget _buildCard({required IconData icon, required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: CustomColors.accentColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: CustomColors.iconColor),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.iconColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  // Input Field Widget
  Widget _buildInputField({
  String? label,  // Make label nullable
  required TextEditingController controller,
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
  Icon? icon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Only display label if it is not null
      if (label != null) 
        Text(
          label,
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: CustomColors.iconColor,
          ),
        ),
      const SizedBox(height: 8),
TextField(
  controller: controller,
  keyboardType: keyboardType,
  decoration: InputDecoration(
    hintText: hintText,
    hintStyle: GoogleFonts.raleway(
      fontSize: 16,
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomColors.iconColor), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomColors.iconColor), // Border color on focus
    ),
    prefixIcon: icon,
  ),
),

    ],
  );
}

}
