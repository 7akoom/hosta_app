import 'package:flutter/material.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:hosta_app/widgets/app_logo.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/theme/app_input_decoration.dart';
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
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    Color selectedButtonBgColor = isDark
        ? AppColors.white
        : AppColors.primaryBlue;
    Color selectedButtonTextColor = isDark ? Colors.black : Colors.white;
    Color unselectedButtonBgColor = isDark ? Colors.black : Colors.white;
    Color unselectedButtonTextColor = isDark ? Colors.white : Colors.black;
    Color resetButtonBgColor = isDark ? AppColors.white : AppColors.primaryBlue;
    Color resetButtonTextColor = isDark ? Colors.black : Colors.white;
    Color backLinkColor = isDark ? Colors.white : AppColors.primaryBlue;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Center(child: AppLogo(width: 50, height: 50)),
              const SizedBox(height: 80),
              Text(
                AppLocalizations.of(
                      context,
                    )?.choose_email_or_phone_to_reset_password ??
                    "Choose email or phone number to reset your password",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEmailSelected
                            ? selectedButtonBgColor
                            : unselectedButtonBgColor,
                        foregroundColor: isEmailSelected
                            ? selectedButtonTextColor
                            : unselectedButtonTextColor,
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
                      child: Text(
                        AppLocalizations.of(context)?.email ?? "Email",
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isEmailSelected
                            ? selectedButtonBgColor
                            : unselectedButtonBgColor,
                        foregroundColor: !isEmailSelected
                            ? selectedButtonTextColor
                            : unselectedButtonTextColor,
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
                      child: Text(
                        AppLocalizations.of(context)?.phone ?? "Phone",
                      ),
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
                      ? AppLocalizations.of(context)?.enter_your_email ??
                            "Enter your email"
                      : AppLocalizations.of(context)?.enter_your_phone ??
                            "Enter your phone number",
                ),
                keyboardType: isEmailSelected
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: resetButtonBgColor,
                    foregroundColor: resetButtonTextColor,
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
                  child: Text(
                    AppLocalizations.of(context)?.reset_password ??
                        "Reset password",
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    AppLocalizations.of(context)?.back_to_signin ??
                        "Back to signin",
                    style: TextStyle(
                      color: backLinkColor,
                      decoration: TextDecoration.underline,
                      decorationColor: backLinkColor,
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
