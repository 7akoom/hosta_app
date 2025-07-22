import 'package:flutter/material.dart';
import '../../widgets/app_logo.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_input_decoration.dart';
import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isEmailSelected = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Center(child: AppLogo(width: 120, height: 120)),
              const SizedBox(height: 8),
              const Text(
                "Choose email or phone number to reset your password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEmailSelected
                            ? AppColors.primaryBlue
                            : Colors.grey[200],
                        foregroundColor: isEmailSelected
                            ? AppColors.white
                            : AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isEmailSelected = true;
                          _controller.clear();
                        });
                      },
                      child: const Text("Email"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isEmailSelected
                            ? AppColors.primaryBlue
                            : Colors.grey[200],
                        foregroundColor: !isEmailSelected
                            ? AppColors.white
                            : AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isEmailSelected = false;
                          _controller.clear();
                        });
                      },
                      child: const Text("Phone"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _controller,
                decoration: appInputDecoration(
                  context,
                  isEmailSelected
                      ? "Enter your email"
                      : "Enter your phone number",
                ),
                keyboardType: isEmailSelected
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationCodeScreen(
                          destination: _controller.text,
                          isPhone: !isEmailSelected,
                        ),
                      ),
                    );
                  },
                  child: const Text("Reset password"),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text(
                    "Back to signin",
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
