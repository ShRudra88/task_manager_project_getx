import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getProgressTasks);
    if (response.isSuccess) {
      isSuccess = true;
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getProgressTaskInProgress = false;
    update();
    return isSuccess;
  }
}