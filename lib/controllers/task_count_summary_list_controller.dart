import 'package:get/get.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  String _messsage = '';

  String get message => _messsage;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp(
      String? firstName,
      String? lastName,
      String? email,
      String? mobile,
      String? password,
      ) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.registration, body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "mobile": mobile,
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      _messsage = 'Account has been created! login please.';
    } else {
      _messsage = 'Account creation failed! try again please.';
      isSuccess = false;
    }
    return isSuccess;
  }
}