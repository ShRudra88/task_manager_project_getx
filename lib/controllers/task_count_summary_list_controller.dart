import 'package:get/get.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/data_network_caller/network_response.dart';
import 'package:task_manager_project_getx/models/task_count_summary.dart';

class TaskCountSummaryListController extends GetxController {
  bool _getTaskCountSummaryInProgress = false;
  TaskCountSummaryListModel _taskCountSummaryListModel =
  TaskCountSummaryListModel();

  bool get getTaskCountSummaryInProgress => _getTaskCountSummaryInProgress;

  TaskCountSummaryListModel get taskCountSummaryListModel =>
      _taskCountSummaryListModel;

  Future<bool> getTaskCountSummaryList() async {
    bool isSuccess = false;
    _getTaskCountSummaryInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      _taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    _getTaskCountSummaryInProgress = false;
    update();
    return isSuccess;
  }
}