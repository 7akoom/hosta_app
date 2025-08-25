import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/generated/app_localizations.dart';

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
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)?.home ?? 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.miscellaneous_services),
          label: AppLocalizations.of(context)?.my_services ?? 'My Services',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppLocalizations.of(context)?.profile ?? 'Profile',
        ),
      ],
    );
  }
}
