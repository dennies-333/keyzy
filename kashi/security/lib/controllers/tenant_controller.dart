import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:security/services/http_services.dart';
import 'package:security/services/local_storage_service.dart';
import 'package:security/models/tenant_model.dart';
import 'package:security/models/visitor_model.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/services/local_storage_service.dart';
import 'package:security/utils/snackbar.dart';
import 'package:security/utils/error_text.dart';

class TenantController extends GetxController {
  // Reactive variables to hold tenant data
  var tenantName = ''.obs;
  var tenantEmail = ''.obs;
  var tenantRole = ''.obs;
  var tenantUnitNumber = ''.obs;
  var familyMembers = <FamilyMember>[].obs;
  var vehicles = <Vehicle>[].obs;
  var visitors = <Visitor>[].obs;  // List of visitors, observable
  var isLoading = true.obs;     
  Timer? _timer;  

  final TextEditingController guestName = TextEditingController();
  final TextEditingController guestVehicleType = TextEditingController();
  final TextEditingController guestVehicleNUmber = TextEditingController();
  final TextEditingController guestDay = TextEditingController();


  // Called when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    fetchTenantDetails(); // Automatically fetch tenant details
    fetchVisitorData(); // Initial fetch
    _startAutoRefresh(); // Start polling
  }


  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchVisitorData();
    });
  }
  // Simulate fetching tenant details
  Future<void> fetchTenantDetails() async {
    try {
      final id = await LocalStorage.getValue("userID");
      final baseendpoint = HttpService.getDetailsEndpoint;
      final endpoint = '$baseendpoint/$id';
      
      var response = await HttpService().get(endpoint);
      Get.log('Raw response: $response');

      if (response is Map<String, dynamic>) {
        TenantModel tenant = TenantModel.fromJson(response);

        tenantName.value = tenant.name;
        tenantEmail.value = tenant.email;
        tenantRole.value = tenant.role;
        tenantUnitNumber.value = tenant.unit_number;
        familyMembers.assignAll(tenant.familyMembers);
        vehicles.assignAll(tenant.vehicles);

        Get.log('Parsed Tenant: ${tenant.toJson()}');
      } else {
        Get.log('Unexpected response format: $response');
      }
    } catch (e) {
      Get.log('Error fetching tenant details: $e');
    }
  }

Future<bool> addGuest() async {
  if (guestName.text.isEmpty ||
      guestVehicleType.text.isEmpty ||
      guestVehicleNUmber.text.isEmpty ||
      guestDay.text.isEmpty) {
        SnackbarUtil.showErrorSnackBar(
          "Missing Information",
          "Please fill in all fields before proceeding.",
          CustomColors.primaryColor,
          Colors.white
        );
    return false;
  } else {
    final tenantId = await LocalStorage.getValue("userID");
    String name = guestName.text.trim();
    String vehicleType = guestVehicleType.text.trim();
    String vehicleNumber = guestVehicleNUmber.text.trim();
    String day = guestDay.text.trim();
    Map<String, dynamic> body = {
      'tenantId': tenantId, 
      'name': name, 
      'vehicleType': vehicleType, 
      'vehicleNumber': vehicleNumber, 
      'day': day, 
    };
    var response = await HttpService().post(HttpService.addGuestEndpoint, body);
    if (response != false) { 
      SnackbarUtil.showErrorSnackBar(
        'Success',
        'Guest added successfully!',
        CustomColors.iconColor, 
        Colors.white,
        snackPosition:  SnackPosition.TOP
      );
      await clearValues();
      return true;

    } else {
      SnackbarUtil.showErrorSnackBar(
        ErrorText.unknownError, 
        ErrorText.guestEntryFailed,
        CustomColors.primaryColor, 
        Colors.white
        );
      return false;
    }
  }
}

Future<bool> clearValues() async {
  guestName.clear();
  guestVehicleType.clear();
  guestVehicleNUmber.clear();
  guestDay.clear();
  return true;
}



Future<void> fetchVisitorData() async {
  try {
    final id = await LocalStorage.getValue("userID");
    if (id == null) {
      Get.log('Error: userID not found in local storage.');
      return;
    }

    final endpoint = '${HttpService.getVisitorEndpoint}/$id';
    isLoading(true); // Show loading indicator

    final response = await HttpService().get(endpoint);

    if (response is List) {
      visitors.assignAll(response.map((json) => Visitor.fromJson(json)).toList());
      Get.log('Fetched ${visitors.length} visitors');
    } else {
      Get.log('Unexpected response format: $response');
    }
  } catch (e) {
    Get.log('Error fetching visitor data: $e');
  } finally {
    isLoading(false); // Hide loading indicator
    update(); // <-- Forces GetBuilder to rebuild
  }
}



// Accept visitor logic
Future<bool> updateVisitor(String visitorId) async {
  try {
    Map<String, dynamic> body = {
      'visitorId': visitorId,
    };
    
    var response = await HttpService().post(HttpService.deleteVisitorEndpoint, body);

    if (response != false) {
      fetchVisitorData();
      update();
      return true;
    } else {
      SnackbarUtil.showErrorSnackBar(
        'Failed',
        'Unable to delete visitor. Please try again.',
        CustomColors.primaryColor,
        Colors.white,
      );
      return false;
    }
  } catch (e) {
    SnackbarUtil.showErrorSnackBar(
      'Error',
      'An error occurred: ${e.toString()}',
      CustomColors.primaryColor,
      Colors.white,
    );
    return false;
  } finally {
    update(); // Ensures the UI rebuilds
  }
}

















  @override
  void onClose() {
    _timer?.cancel(); // Stop the timer when the controller is destroyed
    super.onClose();
  }

}
