import 'package:get/get.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/utility/urls.dart';

import '../data_network_caller/network_caller.dart';

class PinVerificationController extends GetxController {
  bool _otpVerifyInProgress = false;

  bool get otpVerifyInProgress => _otpVerifyInProgress;
  String _message = '';

  String get message => _message;

  Future<bool> otpVerify(String email, String otp) async {
    bool isSuccess = false;
    _otpVerifyInProgress = true;
    update();

    final NetworkResponse response =  await NetworkCaller().getRequest(Urls.recoveryOTPUrl(email, otp));
    _otpVerifyInProgress = false;
    update();

    if (response.isSuccess && response.jsonResponse['status'] == 'success') {
      isSuccess = true;
      _message = 'OTP is Verified';
    } else {
      _message = 'Wrong OTP. Try again';
      isSuccess = false;
    }
      update();
    return isSuccess;
  }
}