import 'package:flutter/material.dart';
import 'package:hosta_app/widgets/app_logo.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/theme/app_input_decoration.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // محاكاة API - استبدلها بـ API حقيقي لاحقًا
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)?.login ?? "Login successful",
        ),
      ),
    );

    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final linkColor = isLight ? AppColors.primaryBlue : AppColors.white;
    final buttonTextColor = isLight ? Colors.white : AppColors.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Center(child: AppLogo(width: 50, height: 50)),
                const SizedBox(height: 80),
                Text(
                  AppLocalizations.of(context)?.sign_in ??
                      "Sign in with your email or phone number",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _buildInputField(
                  controller: _identifierController,
                  hint:
                      AppLocalizations.of(context)?.email ??
                      "Email or Mobile number",
                  validator: (val) => val == null || val.isEmpty
                      ? AppLocalizations.of(context)?.email ??
                            "Please enter email or phone"
                      : null,
                ),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      AppLocalizations.of(context)?.forgot_password ??
                          "Forgot Password?",
                      style: TextStyle(
                        color: linkColor,
                        decoration: TextDecoration.underline,
                        decorationColor: linkColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              buttonTextColor,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)?.sign_in ?? "Sign in",
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.dont_have_account ??
                            "Don't have an account? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          AppLocalizations.of(context)?.sign_up ?? "Signup",
                          style: TextStyle(
                            color: linkColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: linkColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: appInputDecoration(
        context,
        hint,
      ).copyWith(suffixIcon: suffixIcon),
      validator: validator,
    );
  }

  Widget _buildPasswordField() {
    return _buildInputField(
      controller: _passwordController,
      hint: AppLocalizations.of(context)?.password ?? "Password",
      obscure: !_isPasswordVisible,
      validator: (val) => val == null || val.length < 6
          ? AppLocalizations.of(context)?.password ?? "Enter valid password"
          : null,
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
    );
  }
}
