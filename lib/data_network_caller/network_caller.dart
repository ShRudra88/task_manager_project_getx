import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:task_manager_project_getx/app.dart';
import 'package:task_manager_project_getx/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/ui/screens/login_screens.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      log(url);
      log(body.toString());
      final Response response =
      await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> getRequest(String url) async {
    try {
      log(url);
      final Response response = await get(Uri.parse(url), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        backToLogin();

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<void> backToLogin() async {

    await AuthController.clearAuthData();

    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
  }
}