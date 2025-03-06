import 'package:get/get.dart';
import 'package:security/services/http_services.dart';
import 'package:security/models/security_tenant_model.dart';
import 'package:security/services/local_storage_service.dart';

class SecurityController extends GetxController {
  var isAuthenticated = false.obs;
  var securityName = ''.obs;
  var tenants = <SecurityModel>[].obs; // Observable list of tenants

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchSecurityDetails();
    await fetchTenants();
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
      } else {
        Get.log('Unexpected response format: $response');
      }
    } catch (e) {
      Get.log('Error fetching tenant details: $e');
    }
  }

  // Getter for tenants list
  List<SecurityModel> get allTenants => tenants.toList();

}
