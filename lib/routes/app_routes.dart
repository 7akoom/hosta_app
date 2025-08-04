import 'package:flutter/material.dart';
import 'package:hosta_app/screens/auth/forgot_password_screen.dart';
import 'package:hosta_app/screens/auth/reset_password_screen.dart';
import 'package:hosta_app/screens/auth/signin_screen.dart';
import 'package:hosta_app/screens/auth/signup_screen.dart';
import 'package:hosta_app/screens/auth/verification_code_screen.dart';
import 'package:hosta_app/screens/home_screen.dart';
import 'package:hosta_app/screens/category_details_screen.dart';
import 'package:hosta_app/screens/service_details_screen.dart';
import 'package:hosta_app/screens/provider_details_screen.dart';
import 'package:hosta_app/screens/provider_reviews_screen.dart';
import 'package:hosta_app/screens/search_screen.dart';
import 'package:hosta_app/screens/profile_screen.dart';
import 'package:hosta_app/screens/chat_screen.dart';
import 'package:hosta_app/screens/main_screen.dart';
import 'package:hosta_app/screens/book_service_screen.dart';
import 'package:hosta_app/screens/schedule_screen.dart';
import 'package:hosta_app/screens/my_services_screen.dart';
import 'package:hosta_app/screens/cancel_booking_screen.dart';
import 'package:hosta_app/screens/notifications_screen.dart';
import 'package:hosta_app/screens/account_screen.dart';
import 'package:hosta_app/screens/settings_screen.dart';
import 'package:hosta_app/screens/support_screen.dart';
import 'package:hosta_app/screens/confirm_payment_screen.dart';
import 'package:hosta_app/screens/favorites_screen.dart';

class AppRoutes {
  static const welcome = '/';
  static const signin = '/signin';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const verification = '/verification';
  static const resetPassword = '/reset-password';
  static const home = '/home';
  static const categoryDetails = '/category-details';
  static const serviceDetails = '/service-details';
  static const providerDetails = '/provider-details';
  static const providerReviews = '/provider-reviews';
  static const search = '/search';
  static const profile = '/profile';
  static const chat = '/chat';
  static const myServices = '/my-services';
  static const bookService = '/book_service';
  static const notifications = '/notifications';
  static const account = '/account';
  static const settings = '/settings';
  static const support = '/support';
  static const schedule = '/schedule';
  static const cancelBooking = '/cancel-booking';
  static const confirmPayment = '/confirm-payment';
  static const favorites = '/favorites';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final name = routeSettings.name ?? '/';

    if (name == welcome) {
      return MaterialPageRoute(builder: (_) => const MainScreen());
    }

    if (name == signin) {
      return MaterialPageRoute(builder: (_) => const SigninScreen());
    }

    if (name == signup) {
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }

    if (name == forgotPassword) {
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    }

    if (name == verification) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => VerificationCodeScreen(
          destination: args['destination'] ?? '',
          isPhone: args['isPhone'] ?? false,
        ),
      );
    }

    if (name == resetPassword) {
      return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
    }

    if (name == home) {
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    }

    if (name == categoryDetails) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => CategoryDetailsScreen(category: args['category']),
      );
    }

    if (name == serviceDetails) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => ServiceDetailsScreen(service: args['service']),
      );
    }

    if (name == providerDetails) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => ProviderDetailsScreen(
          providerId: args['provider_id'] ?? args['providerId'] ?? '',
          service: args['service'],
        ),
      );
    }

    if (name == providerReviews) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => ProviderReviewsScreen(provider: args['provider']),
      );
    }

    if (name == search) {
      return MaterialPageRoute(builder: (_) => const SearchScreen());
    }

    if (name == profile) {
      return MaterialPageRoute(builder: (_) => const ProfileScreen());
    }

    if (name == chat) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => ChatScreen(
          provider: args['provider'],
          serviceId: args['serviceId'],
        ),
      );
    }

    if (name == bookService) {
      return MaterialPageRoute(builder: (_) => const BookServiceScreen());
    }

    if (name == schedule) {
      return MaterialPageRoute(builder: (_) => const ScheduleScreen());
    }

    if (name == myServices) {
      return MaterialPageRoute(builder: (_) => const MyServicesScreen());
    }

    if (name == cancelBooking) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => CancelBookingScreen(bookingId: args['bookingId']),
      );
    }

    if (name == notifications) {
      return MaterialPageRoute(builder: (_) => const NotificationsScreen());
    }

    if (name == account) {
      return MaterialPageRoute(builder: (_) => const AccountScreen());
    }

    if (name == settings) {
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    }

    if (name == support) {
      return MaterialPageRoute(builder: (_) => const SupportScreen());
    }

    if (name == confirmPayment) {
      final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (_) => ConfirmPaymentScreen(
          bookingId: args['bookingId'] ?? '',
          providerName: args['providerName'] ?? '',
          amount: args['amount'] ?? 0.0,
        ),
      );
    }

    if (name == favorites) {
      return MaterialPageRoute(builder: (_) => const FavoritesScreen());
    }

    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }
}
