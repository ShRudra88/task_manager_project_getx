import 'package:get/get.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/models/task_list_model.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();


  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompletedTasks);
    if (response.isSuccess) {
      isSuccess = true;
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCompletedTaskInProgress = false;
    update();

    return isSuccess;
  }
}