import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppColors.dark : Colors.white,
      elevation: 0,
      flexibleSpace: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;

          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: user?.avatar != null
                      ? NetworkImage(user!.avatar!)
                      : null,
                  child: user?.avatar == null
                      ? Icon(
                          Icons.person,
                          size: 32,
                          color: isDark ? AppColors.white : AppColors.dark,
                        )
                      : null,
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
                        user?.name ?? 'Guest',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isDark ? AppColors.white : AppColors.dark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/chat.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isDark ? AppColors.white : AppColors.dark,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/chats');
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isDark ? AppColors.white : AppColors.dark,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/heart.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isDark ? AppColors.white : AppColors.dark,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/favorites');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}

// AppBar للصفحات الأخرى (بدون صورة المستخدم واسمه، مع سهم الرجوع)
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppColors.dark : AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        // Chat Icon
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/chats');
          },
          icon: SvgPicture.asset(
            'assets/icons/chat.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        // Notifications Icon
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
          icon: SvgPicture.asset(
            'assets/icons/notification.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        // Favorites Icon
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
          icon: SvgPicture.asset(
            'assets/icons/heart.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
