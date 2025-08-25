import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hosta_app/widgets/custom_bottom_navigation.dart';
import 'package:hosta_app/screens/home_screen.dart';
import 'package:hosta_app/screens/my_services_screen.dart';
import 'package:hosta_app/screens/profile_screen.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MyServicesScreen(),
    ProfileScreen(),
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime? _lastBackPressTime;

  bool _handleBackPress(BuildContext context) {
    if (_selectedIndex != 0) {
      // إذا لم نكن في الشاشة الرئيسية، نعود إليها
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }

    // في الشاشة الرئيسية، نتحقق من النقر المزدوج
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.press_back_again ??
                'Press back again to exit',
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      return false;
    }

    // إذا تم الضغط مرتين خلال ثانيتين، نخرج من التطبيق
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          final shouldPop = _handleBackPress(context);
          if (shouldPop) {
            // إذا كان يجب الخروج، نخرج من التطبيق
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTap,
        ),
      ),
    );
  }
}
