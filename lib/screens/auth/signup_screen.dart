import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/theme/app_input_decoration.dart';
import 'package:hosta_app/widgets/app_logo.dart';
import 'package:logger/logger.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _agreed = false;
  final List<String> _cities = ['Erbil', 'Sulaymani', 'Duhok'];
  final String _selectedCountry = 'Iraq';

  @override
  void dispose() {
    _dobController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermissionAndRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final granted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission"),
        content: const Text(
          "Please allow location access to continue registration.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Deny"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (granted == true) {
      LocationPermission permission = await Geolocator.requestPermission();

      if (!mounted) return;

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        try {
          Position position = await Geolocator.getCurrentPosition();

          if (!mounted) return;

          logger.i(
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
          );

          Navigator.pushReplacementNamed(context, '/home');
        } catch (e) {
          logger.e("Failed to get location: $e");

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to get current location.')),
          );
        }
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied!')),
        );
      }
    }
  }

  Future<void> _showCityPicker() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: AlertDialog(
            title: const Text("Select City"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _cities.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final city = _cities[index];
                  return ListTile(
                    title: Text(city),
                    onTap: () {
                      _cityController.text = city;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.white : AppColors.primaryBlue;
    final textOnPrimaryColor = isDark ? AppColors.dark : AppColors.white;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Center(child: AppLogo(width: 50, height: 50)),
                const SizedBox(height: 80),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign up with your email or phone number",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: appInputDecoration(context, "Name"),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required field' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: appInputDecoration(context, "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: appInputDecoration(context, "Mobile number"),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),

                Offstage(
                  offstage: true,
                  child: DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    items: const [
                      DropdownMenuItem(value: 'Iraq', child: Text('Iraq')),
                    ],
                    onChanged: (_) {},
                    decoration: appInputDecoration(context, "Country"),
                  ),
                ),

                GestureDetector(
                  onTap: _showCityPicker,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: appInputDecoration(context, "City"),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: appInputDecoration(context, "Address"),
                ),
                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: appInputDecoration(context, "Password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: appInputDecoration(context, "Confirm Password")
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
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
                const SizedBox(height: 12),

                // Date of Birth
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: appInputDecoration(context, "Date of Birth"),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000, 1, 1),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      _dobController.text =
                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Agreement Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _agreed,
                      fillColor: WidgetStateProperty.all<Color>(Colors.white),
                      checkColor: Colors.black,
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _agreed = val ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          const Text("By signing up, you agree to the "),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Terms of service",
                              style: TextStyle(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: primaryColor,
                              ),
                            ),
                          ),
                          const Text(" and "),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Privacy policy",
                              style: TextStyle(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: textOnPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _agreed
                        ? _requestLocationPermissionAndRegister
                        : null,
                    child: const Text("Sign up"),
                  ),
                ),
                const SizedBox(height: 16),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/signin'),
                      child: Text(
                        "Signin",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
