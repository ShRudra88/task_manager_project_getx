import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/controllers/cancelled_task_controller.dart';
import 'package:task_manager_project_getx/controllers/completed_task_controller.dart';
import 'package:task_manager_project_getx/controllers/edit_profile_controller.dart';
import 'package:task_manager_project_getx/controllers/forgot_password_controller.dart';
import 'package:task_manager_project_getx/controllers/login_controller.dart';
import 'package:task_manager_project_getx/controllers/new_task_controller.dart';
import 'package:task_manager_project_getx/controllers/pin_verification_controller.dart';
import 'package:task_manager_project_getx/controllers/progress_task_controller.dart';
import 'package:task_manager_project_getx/controllers/reset_password_controller.dart';
import 'package:task_manager_project_getx/controllers/task_count_summary_list_controller.dart';
import 'package:task_manager_project_getx/ui/screens/Splash_screen.dart';

import 'controllers/add_new_task_controller.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      home: const SplashScreen(),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              )),
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                // maximumSize: const Size.fromWidth(double.infinity)
              ))),
         initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(PinVerificationController());
    Get.put(SignUpController());
    Get.put(ResetPassWordController());
    Get.put(ForgotPasswordController());
    Get.put(EditProfileController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(TaskCountSummaryListController());
    Get.put(CancelledTaskController());
    Get.put(AddNewTaskController());
    Get.put(LoginController());
    Get.put(NewTaskController());
  }
}