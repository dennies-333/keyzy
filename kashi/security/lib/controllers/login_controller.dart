import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security/services/http_services.dart';
import 'package:security/services/local_storage_service.dart';
import 'package:security/utils/snackbar.dart';
import 'package:security/views/main_page.dart';
import 'package:security/views/admin_view.dart';
import 'package:security/views/security_view.dart';
import 'package:security/utils/error_text.dart';

class LoginController extends GetxController {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();


  var usernameError = ''.obs;  // Reactive email error
  var passwordError = ''.obs;  // Reactive password error

  Future<bool> login() async {
    usernameError.value = '';
    passwordError.value = '';

    String username = usernameCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if (username.isEmpty) {
      usernameError.value = 'Username is required';
    }
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
    }

    if (username.isNotEmpty && password.isNotEmpty) {
      Map<String, dynamic> body = {
        'username': username, // your username value
        'password': password, // your password value
      };

      var response = await HttpService().post(HttpService.signInEndpoint, body);

      if (response != false) {       
        var userID = response['user']['id'].toString();  
        var role = response['user']['role'];
        await LocalStorage.setValue('userID', userID);
        if (role == 'admin') {
        Get.off(() => AdminPage(),
          transition: Transition.rightToLeft, // You can change this to any transition you like
          duration: Duration(milliseconds: 300), // You can adjust the duration
        );

        } else if (role == 'tenant') {
          Get.to(() => MainPage(),
          transition: Transition.rightToLeft, // You can change this to any transition you like
          duration: Duration(milliseconds: 300), );
        } else {
          Get.off(() => SecurityPage());
        }
        return true;
      } else {
        SnackbarUtil.showErrorSnackBar(ErrorText.loginFailed, ErrorText.invalidCredentials, Colors.red, Colors.white);
        return false;
      }
    }
    return false;
  }





}
