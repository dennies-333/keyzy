import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/controllers/security_controller.dart';
import 'package:security/components/gate_controls_card.dart';
import 'package:security/components/quick_actions_card.dart';
import 'package:security/components/emergency_contacts_card.dart';
import 'package:security/controllers/auth_controller.dart';

class SecurityDetailView extends StatelessWidget {

  SecurityDetailView({super.key});
  final SecurityController controller = Get.find();
  final AuthController authController = Get.find();
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                // Greeting
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: CustomColors.iconColor),
                  iconSize: 28,
                  splashRadius: 24,
                  onPressed: () {
                    authController.logout();
                  },
                ),
                SizedBox(width: 10),
                // Greeting with Obx
                Obx(() => Text(
                      'Hi, ${controller.securityName.value} 👋',
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),


                const SizedBox(height: 20),
                const Divider(thickness: 1, height: 24),

                // Gate Controls Card
                GateControlsCard(),

                const SizedBox(height: 20),

                // Quick Actions Card
               QuickActionsCard(),

                const SizedBox(height: 20),

                // Emergency Contacts Card
                EmergencyContactsCard(),
              ],
            ),
          ),
        ),
      ),
    ),
    ),
    );
  }
}


