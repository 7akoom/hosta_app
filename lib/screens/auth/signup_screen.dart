import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/app_logo.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_input_decoration.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _agreed = false;
  final TextEditingController _dobController = TextEditingController();
  String? _selectedCity;
  final List<String> _cities = ['Erbil', 'Sulaymani', 'Duhok'];

  String _selectedCountry = 'Iraq';

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermissionAndRegister() async {
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

    if (granted == true) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();
        print(
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: AppLogo(width: 120, height: 120)),
                const SizedBox(height: 24),
                const Text(
                  "Sign up with your email or phone number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(decoration: appInputDecoration(context, "Name")),
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
                    items: [
                      DropdownMenuItem(value: 'Iraq', child: Text('Iraq')),
                    ],
                    onChanged: (value) {},
                    decoration: appInputDecoration(context, "Country"),
                  ),
                ),

                DropdownButtonFormField<String>(
                  decoration: appInputDecoration(context, "City"),
                  value: _selectedCity,
                  items: _cities
                      .map(
                        (city) =>
                            DropdownMenuItem(value: city, child: Text(city)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  decoration: appInputDecoration(context, "Address"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: appInputDecoration(context, "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
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
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primaryBlue,
                              onPrimary: AppColors.white,
                              onSurface: AppColors.dark,
                            ),
                            dialogTheme: const DialogThemeData(
                              backgroundColor: AppColors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      _dobController.text =
                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agreed,
                      fillColor: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.primaryBlue;
                        }
                        return null;
                      }),
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
                            child: const Text(
                              "Terms of service",
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const Text(" and "),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Privacy policy",
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                    onPressed: _agreed
                        ? _requestLocationPermissionAndRegister
                        : null,
                    child: const Text("Register"),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: const Text(
                          "Signin",
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
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
}
