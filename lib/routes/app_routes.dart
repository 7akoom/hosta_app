import 'package:flutter/material.dart';
import 'package:hosta_app/screens/auth/forgot_password_screen.dart';
import 'package:hosta_app/screens/auth/reset_password_screen.dart';
import 'package:hosta_app/screens/auth/signin_screen.dart';
import 'package:hosta_app/screens/auth/signup_screen.dart';
import 'package:hosta_app/screens/auth/verification_code_screen.dart';
import 'package:hosta_app/screens/welcome_screen.dart';
import 'package:hosta_app/screens/home_screen.dart';

class AppRoutes {
  static const welcome = '/';
  static const signin = '/signin';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const verification = '/verification';
  static const resetPassword = '/reset-password';
  static const home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case verification:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => VerificationCodeScreen(
            destination: args['destination'] ?? '',
            isPhone: args['isPhone'] ?? false,
          ),
        );
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
