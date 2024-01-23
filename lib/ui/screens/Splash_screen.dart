import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_manager_project_getx/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/ui/screens/login_screens.dart';
import 'package:task_manager_project_getx/ui/screens/main_bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  Future<void> goToLogin() async {
    final bool isLoggedIn = await Get.find<AuthController>().checkAuthState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offAll(
          isLoggedIn ? const MainBottomNavScreen() : const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/background.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}