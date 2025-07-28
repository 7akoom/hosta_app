import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppColors.dark : Colors.white,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/1.jpg',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi!',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                  Text(
                    'Hassan AlBony',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.message_outlined,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
