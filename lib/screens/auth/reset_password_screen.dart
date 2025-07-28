import 'package:flutter/material.dart';
import 'package:hosta_app/widgets/app_logo.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/theme/app_input_decoration.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password changed successfully!")),
      );
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Center(child: AppLogo(width: 50, height: 50)),
                const SizedBox(height: 80),
                const Text(
                  "Enter new password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: appInputDecoration(
                    context,
                    "New password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter password please";
                    } else if (val != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    if (val.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmController,
                  obscureText: !_showConfirmPassword,
                  decoration: appInputDecoration(
                    context,
                    "Password confirmation",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    if (val != _passwordController.text) {
                      return "The passwords do not match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? AppColors.white
                          : AppColors.primaryBlue,
                      foregroundColor: isDark
                          ? AppColors.dark
                          : AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _onConfirm,
                    child: const Text("Confirm"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
