import 'package:get/get.dart';

class PinVerificationController extends GetxController {
  bool _otpVerifyInProgress = false;

  bool get otpVerifyInProgress => _otpVerifyInProgress;
  String _message = '';

  String get message => _message;

  Future<bool> otpVerify(String email, String otp) async {
    bool isSuccess = false;
    _otpVerifyInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.recoveryOTPUrl(email, otp));
    _otpVerifyInProgress = false;
    update();

    if (response != null) {
      if (response.isSuccess && response.jsonResponse['status'] == 'success') {
        isSuccess = true;
        _message = 'OTP is Verified';
      } else {
        _message = 'Wrong OTP. Try again';
        isSuccess = false;
      }
    } else {
      _message = 'OTP verification failed. Try again!';
      isSuccess = false;
    }
    update();
    return isSuccess;
  }
}