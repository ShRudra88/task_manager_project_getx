// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:task_manager_project_getx/data_network_caller/network_caller.dart';
import 'package:task_manager_project_getx/models/task.dart';
import 'package:task_manager_project_getx/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project_getx/utility/urls.dart';
import 'package:get/get.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? ' ', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTaskStatus(String id) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.deleteTaskStatus(widget.task.sId ?? ' '));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? ' ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.task.description ?? ' ',
            ),
            Text('Date:  ${widget.task.createdDate} '),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.lightBlue,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpadteStatusModal();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteTaskModal(widget.task.sId!);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpadteStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
      title: Text(e.name),
      onTap: () {
        updateTaskStatus(e.name);

        Get.offAll(() => const MainBottomNavScreen());
      },
    ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Update Status',
              style: TextStyle(),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                          color: Colors.blueGrey,
                        )),
                  ),
                ],
              )
            ],
          );
        });
  }

  void deleteTaskModal(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Confirm Delete',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      deleteTaskStatus(id);
                      Get.back();
                    },
                    child: const Text('Yes',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('No',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                  ),
                ],
              )
            ],
          );
        });
  }
}