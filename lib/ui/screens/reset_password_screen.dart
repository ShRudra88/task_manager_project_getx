import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/controllers/reset_password_controller.dart';
import 'package:task_manager_project_getx/ui/screens/login_screens.dart';
import 'package:task_manager_project_getx/ui/widgets/body_background.dart';
import 'package:task_manager_project_getx/ui/widgets/snack_message.dart';


class ResetPasswordScreen extends StatefulWidget {
  String? email;
  String? otp;

  ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  final ResetPassWordController _resetPassWordController = Get.find<ResetPassWordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        'Set Password',
                        // style: Theme.of(context).textTheme.headlineMedium,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Minimum Password length Should be more than 6 letters ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your mobile';
                          }
                          if (value!.length < 6) {
                            return 'Enter password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _confirmPasswordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (String? value) {
                          if (_passwordTEController.text != value) {
                            return 'Password did not match, Try again!';
                          }
                          if (value?.isEmpty ?? true) {
                            return 'Enter your Confirm password';
                          }
                          if (value!.length < 6) {
                            return 'Enter password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: GetBuilder<ResetPassWordController>(
                            builder: (resetPassWordController) {
                              return Visibility(
                                visible:
                                resetPassWordController.resetPasswordInProgress ==
                                    false,
                                replacement: const Center(
                                  child: Center(child: CircularProgressIndicator()),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    resetPass();
                                  },
                                  child: const Text('Confirm'),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account ?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => const LoginScreen());
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Future<void> resetPass() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await _resetPassWordController.resetPass(
        widget.email.toString(),
        widget.otp.toString(),
        _passwordTEController.text);

    if (response) {
      if (mounted) {
        Get.offAll(const LoginScreen());
        showSnackMessage(context, _resetPassWordController.message);
      }
    } else {
      if (mounted) {
        showSnackMessage(context, _resetPassWordController.message, true);
      }
    }
  }
}