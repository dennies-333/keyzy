import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HttpService {

   static const String baseUrl = 'http://192.168.1.38:5000/api'; 
   static String get signInEndpoint => '$baseUrl/auth/signin';
   static String get getDetailsEndpoint => '$baseUrl/auth/users';
   static String get addGuestEndpoint => '$baseUrl/guest/addGuest';
   static String get getVisitorEndpoint => '$baseUrl/visitors/getVisitors';
   static String get deleteVisitorEndpoint => '$baseUrl/visitors/deleteVisitor';


  // Function to handle GET requests
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      // Handle the response using the handleResponse function
      return await handleResponse(response);
    } catch (e) {
      throw Exception('Error making GET request: $e');
    }
  }

  // Function to handle POST requests
  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      Get.log(url);
      Get.log(body.toString());
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      Get.log(response.statusCode.toString());
      // Handle the response using the handleResponse function
      return await handleResponse(response);
    } catch (e) {
      throw Exception('Error making POST request: $e');
    }
  }

  // Function to handle HTTP responses
  Future<dynamic> handleResponse(http.Response response) async {
    // If status code is 200 or 201, return the response body
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      // If not, return false
      return false;
    }
  }
}
