import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project_getx/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/controllers/task_count_summary_list_controller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/models/user_model.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/utility/urls.dart';
import 'new_task_controller.dart';

class EditProfileController extends GetxController {
  AuthController authController = Get.find<AuthController>();
  bool _updateProfileInProgress = false;
  String _message = '';

  String get message => _message;
  bool get updateProfileInProgress => _updateProfileInProgress;

  Future<bool> updateProfile(String? firstName, String? lastName, String? email,
      String? mobile, String? password, XFile? photo) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    update();
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobile": mobile,
    };

    if (password!.isNotEmpty) {
      inputData['password'] = password;
    }
    if (photo != null) {
      List<int> imageBytes = await photo.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );

    _updateProfileInProgress = false;
    update();
    if (response.isSuccess) {
      Get.find<NewTaskController>().getNewTaskList();
      Get.find<TaskCountSummaryListController>().getTaskCountSummaryList();
      authController.updateUserInformation(UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photoInBase64 ?? authController.user?.photo));


      _message = 'Update profile success!';
      isSuccess = true;
    } else {
      _message = 'Update profile failed. Try again.';
      isSuccess = false;
    }
    update();
    return isSuccess;
  }
}