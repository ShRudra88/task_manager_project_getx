import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/controllers/auth_controller.dart';
import 'package:task_manager_project_getx/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_project_getx/ui/screens/login_screens.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      Uint8List imageBytes =
      const Base64Decoder().convert(authController.user?.photo ?? '');
      return ListTile(
        onTap: () {
          if (widget.enableOnTap == true) {
            Get.to(() => const EditProfileScreen());
          }
        },
        leading: CircleAvatar(
          child: authController.user?.photo == null
              ? const Icon(Icons.person)
              : ClipOval(
            child: Image.memory(
              imageBytes,
              fit: BoxFit.cover,
            ),
            //child:Icon(Icons.abc),
          ),
        ),
        title: Text(
          fullName(authController),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          authController.user?.email ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () async {
            AuthController.clearAuthData();
            if (mounted) {
              setState(() {});
              Get.offAll(const LoginScreen());
            }
          },
          icon: const Icon(Icons.logout),
        ),
        tileColor: Colors.green,
      );
    });
  }

  String fullName(AuthController authController) {
    return '${authController.user?.firstName ?? ''} ${authController.user?.lastName ?? ''}';
  }
}