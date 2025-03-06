import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security/services/http_services.dart';
import 'package:security/models/security_tenant_model.dart';
import 'package:security/services/local_storage_service.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/utils/snackbar.dart';

class SecurityController extends GetxController {

  Timer? _timer;  
  var isAuthenticated = false.obs;
  var securityName = ''.obs;
  var tenants = <SecurityModel>[].obs; // Observable list of tenants
    var selectedTenant = Rxn<SecurityModel>(); // Selected tenant
  final TextEditingController visitorNameController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();

  final RxString visitorType = 'Family'.obs;
  final RxString searchQuery = ''.obs;
  final List<String> visitorTypes = [
    'Family',
    'Friend',
    'Delivery',
    'Service Provider',
    'Other'
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchSecurityDetails();
    fetchTenants();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    Get.log('Starting auto-refresh timer');
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchTenants();
    });
  }

  // Update authentication status
  Future<void> fetchSecurityDetails() async {
    try {
      final id = await LocalStorage.getValue("userID");
      final baseendpoint = HttpService.getDetailsEndpoint;
      final endpoint = '$baseendpoint/$id';
      
      var response = await HttpService().get(endpoint);
      Get.log('Raw response: $response');

      if (response is Map<String, dynamic>) {
        securityName.value = response['name'];
        Get.log('Stored Security Details: ${response}');
      } else {
        Get.log('Unexpected response format: $response');
      }
    } catch (e) {
      Get.log('Error fetching tenant details: $e');
    }
    Get.log(securityName.value);
  }

  // Fetch and store tenant data
  Future<void> fetchTenants() async {
    try {
      var response = await HttpService().get(HttpService.getTenantsEndpoint);

      if (response is List) {
        tenants.value = response
            .map((tenantData) => SecurityModel.fromJson(tenantData))
            .toList();
              Get.log(response.toString());
      } else {
        Get.log('Unexpected response format: $response');
      }
    } catch (e) {
      Get.log('Error fetching tenant details: $e');
    }
  }

     Future<bool> registerVisitor() async {
  try {
    // Collect the data
    final visitorName = visitorNameController.text;
    final purpose = purposeController.text;
    final tenantInfo = selectedTenant.value?.id ?? '';
    final visitorTypeValue = visitorType.value;

    // Logging the values
    Get.log("Visitor Name: $visitorName");
    Get.log("Purpose: $purpose");
    Get.log("Tenant Info: $tenantInfo");
    Get.log("Visitor Type: $visitorTypeValue");

    // Check for empty fields
    if (visitorName.isEmpty) {
      SnackbarUtil.showErrorSnackBar(
        'Error',
        'Please enter the visitor name.',
        Colors.redAccent,
        Colors.white,
      );
      return false;
    }
    if (purpose.isEmpty) {
      SnackbarUtil.showErrorSnackBar(
        'Error',
        'Please enter the purpose.',
        Colors.redAccent,
        Colors.white,
      );
      return false;
    }
    if (tenantInfo.isEmpty) {
      SnackbarUtil.showErrorSnackBar(
        'Error',
        'Please select tenant information.',
        Colors.redAccent,
        Colors.white,
      );
      return false;
    }
    if (visitorTypeValue.isEmpty) {
      SnackbarUtil.showErrorSnackBar(
        'Error',
        'Please select a visitor type.',
        Colors.redAccent,
        Colors.white,
      );
      return false;
    }

    final body = {
      'tenantId': tenantInfo,
      'name': visitorName,
      'purpose': purpose,
      'relationship': visitorTypeValue,
    };
    // Placeholder for API call
    var response = await HttpService().post(HttpService.addVisitorsEndpoint, body);
    if (response is Map<String, dynamic>) {
      Get.log('Visitor registered successfully: $response');
      SnackbarUtil.showErrorSnackBar("Visitor Registered", "Wait for confirmation", CustomColors.iconColor, Colors.white);
      await clearValues();
    } else {
      Get.log('Unexpected response format: $response');
      SnackbarUtil.showErrorSnackBar(
        'Error',
        'Please try again!',
        Colors.redAccent,
        Colors.white,
      );
    }

    // If everything is valid
    return true;
  } catch (e) {
    Get.log('Error registering visitor: $e');
    // _showSnackbar('An error occurred while registering the visitor.');
    return false;
  }
}

 Future<bool> clearValues() async {
    visitorNameController.clear();
    purposeController.clear();
    selectedTenant.value = null;
    visitorType.value = 'Family';
    return true;
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

}
