import 'package:get/get.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/utility/urls.dart';

class ResetPassWordController extends GetxController {
  bool _resetPasswordInProgress = false;

  bool get resetPasswordInProgress => _resetPasswordInProgress;
  String _message = '';

  String get message => _message;

  Future<bool> resetPass(
      String email,
      String otp,
      String password,
      ) async {
    _resetPasswordInProgress = true;
    bool isSuccess = false;

    update();
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.recoverResetPassword, body: {
      "email": email,
      "OTP": otp,
      "password": password,
    });
    _resetPasswordInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      _message = 'Password Updated.';
    } else {
      isSuccess = false;
      _message = 'Set password Failed.';
    }
    update();
    return isSuccess;
  }
}