import 'package:get/get.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/utility/urls.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  String _messsage = '';

  String get message => _messsage;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp(
      String? email,
      String? firstName,
      String? lastName,
      String? mobile,
      String? password,
      ) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.registration, body: {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "mobile": mobile,
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      _messsage = 'Account has been created! Please login.';
    } else {
      _messsage = 'Account creation failed! Please try again.';
      isSuccess = false;
    }
    return isSuccess;
  }
}