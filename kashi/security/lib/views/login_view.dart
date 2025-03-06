
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/components/custom_text_field.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'lib/assets/images/logo-blue.png',
                width: 120,
                height: 120,
              ),
              Transform.translate(
                offset: const Offset(0, -50), // Move upwards by 50 pixels
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: OverflowBox(
                        maxWidth: 400,
                        maxHeight: 400,
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          'lib/assets/lottie/background.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              // Welcome text
              Text(
                "Secure Access to Your Community",
                style: TextStyle(
                  fontFamily: "Satoshi",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.iconColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Manage guests and control access seamlessly.",
                style: TextStyle(
                  fontFamily: "Satoshi",
                  fontSize: 16,
                  color: CustomColors.iconColor,
                ),
              ),
              const SizedBox(height: 30),
              // Username field
              Obx(() => CustomTextField(
                    controller: controller.usernameCtrl,
                    labelText: "Username",
                    icon: Icons.person,
                    textColor: CustomColors.primaryColor,
                    fillColor: CustomColors.white,
                    iconColor: CustomColors.iconColor,
                    errorText: controller.usernameError.value.isEmpty
                        ? null
                        : controller.usernameError.value,
                  )),
              const SizedBox(height: 20),
              // Password field
              Obx(() => CustomTextField(
                    controller: controller.passwordCtrl,
                    labelText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    textColor: CustomColors.primaryColor,
                    fillColor: CustomColors.white,
                    iconColor: CustomColors.iconColor,
                    errorText: controller.passwordError.value.isEmpty
                        ? null
                        : controller.passwordError.value,
                  )),
              const SizedBox(height: 30),
              // Login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.iconColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async => await controller.login(),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Forgot Password link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: "Satoshi",
                        color: CustomColors.iconColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

