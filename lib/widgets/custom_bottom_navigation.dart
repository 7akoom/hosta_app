import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: isDark ? AppColors.dark : Colors.white,
      selectedItemColor: isDark ? AppColors.white : AppColors.primaryBlue,
      unselectedItemColor: isDark
          ? AppColors.white.withAlpha((255 * 0.7).toInt())
          : AppColors.dark.withAlpha((255 * 0.7).toInt()),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.miscellaneous_services),
          label: 'My services',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
