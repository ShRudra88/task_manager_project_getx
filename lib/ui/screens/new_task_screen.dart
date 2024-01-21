import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  NewTaskController _newTaskController = Get.find<NewTaskController>();
  TaskCountSummaryListController _taskCountSummaryListController =
  Get.find<TaskCountSummaryListController>();


  @override
  void initState() {
    super.initState();
    Get.find<TaskCountSummaryListController>().getTaskCountSummaryList();
    _newTaskController.getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Get.to(()=>AddNewTaskScreen());

          if (response != null && response == true) {
            _newTaskController.getNewTaskList();
            _taskCountSummaryListController.getTaskCountSummaryList();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),
            GetBuilder<TaskCountSummaryListController>(
                builder: (taskCountSummaryListController) {
                  return Visibility(
                    visible: taskCountSummaryListController
                        .getTaskCountSummaryInProgress ==
                        false,
                    replacement: const LinearProgressIndicator(),
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: taskCountSummaryListController
                              .taskCountSummaryListModel
                              .taskCountList
                              ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            TaskCount taskCount = taskCountSummaryListController
                                .taskCountSummaryListModel.taskCountList![index];
                            return FittedBox(
                              child: SummaryCard(
                                count: taskCount.sum.toString(),
                                title: taskCount.sId ?? '',
                              ),
                            );
                          }),
                    ),
                  );
                }),
            Expanded(
              child:
              GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.getNewTaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      newTaskController.getNewTaskList();
                      _taskCountSummaryListController.getTaskCountSummaryList();
                    },
                    child: ListView.builder(
                      itemCount:
                      newTaskController.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task:
                          newTaskController.taskListModel.taskList![index],
                          onStatusChange: () {
                            newTaskController.getNewTaskList();
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
      ),
    );
  }
}