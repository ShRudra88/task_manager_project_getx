import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/controllers/completed_task_controller.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  CompletedTaskController _completedTaskController =
  Get.find<CompletedTaskController>();

  @override
  void initState() {
    _completedTaskController.getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ProfileSummaryCard(),
              GetBuilder<CompletedTaskController>(
                  builder: (completedTaskController) {
                    return Expanded(
                      child: Visibility(
                        visible:
                        completedTaskController.getCompletedTaskInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: RefreshIndicator(
                          onRefresh: completedTaskController.getCompletedTaskList,
                          child: ListView.builder(
                            itemCount: completedTaskController
                                .taskListModel.taskList?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                task: completedTaskController
                                    .taskListModel.taskList![index],
                                onStatusChange: () {
                                  completedTaskController.getCompletedTaskList();
                                },
                                showProgress: (inProgress) {},
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}