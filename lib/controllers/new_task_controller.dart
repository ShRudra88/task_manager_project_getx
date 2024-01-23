import 'package:get/get.dart';


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