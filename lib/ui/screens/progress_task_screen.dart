import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/controllers/progress_task_controller.dart';
import 'package:task_manager_project_getx/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_project_getx/ui/widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  final ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _progressTaskController.getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                child: GetBuilder<ProgressTaskController>(
                    builder: (progressTaskController) {
                      return Visibility(
                        visible:
                        progressTaskController.getProgressTaskInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: RefreshIndicator(
                          onRefresh: progressTaskController.getProgressTaskList,
                          child: ListView.builder(
                            itemCount:
                            progressTaskController.taskListModel.taskList?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                task: progressTaskController
                                    .taskListModel.taskList![index],
                                onStatusChange: () {
                                  progressTaskController.getProgressTaskList();
                                },
                                showProgress: (inProgress) {},
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}