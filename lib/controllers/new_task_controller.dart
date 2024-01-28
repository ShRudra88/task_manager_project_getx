import 'package:get/get.dart';
import 'package:task_manager_project_getx/controllers/task_count_summary_list_controller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/models/task_list_model.dart';
import 'package:task_manager_project_getx/utility/urls.dart';


class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getNewTasks);
    _getNewTaskInProgress = false;
    if (response.isSuccess) {
      Get.find<TaskCountSummaryListController>().getTaskCountSummaryList();
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }

    update();
    return isSuccess;
  }
}