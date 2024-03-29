import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project_getx/controllers/pin_verification_controller.dart';
import 'package:task_manager_project_getx/ui/screens/login_screens.dart';
import 'package:task_manager_project_getx/ui/screens/reset_password_screen.dart';
import 'package:task_manager_project_getx/ui/widgets/body_background.dart';
import 'package:task_manager_project_getx/ui/widgets/snack_message.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();

  final PinVerificationController _pinVerificationController =  Get.find<PinVerificationController>();

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
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'A 6 digit OTP will be sent to your email address',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PinCodeTextField(
                      controller: _otpTEController,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.green,
                        inactiveColor: Colors.blue,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<PinVerificationController>(
                          builder: (pinVerificationController) {
                            return Visibility(
                              visible:
                              pinVerificationController.otpVerifyInProgress ==
                                  false,
                              replacement:
                              const Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                onPressed: () {
                                  otpVerify();
                                },
                                child: const Text('Verify'),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAll(() => const LoginScreen());
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> otpVerify() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _pinVerificationController.otpVerify(
        widget.email.toString(), _otpTEController.text);

    if (response) {
      if (mounted) {
        showSnackMessage(context, _pinVerificationController.message);
        Get.offAll(() => ResetPasswordScreen(
            email: widget.email, otp: _otpTEController.toString()));
      }
    } else {
      if (mounted) {
        showSnackMessage(context, _pinVerificationController.message, true);
      }
    }
  }
}