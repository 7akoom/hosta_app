import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/theme/app_fonts.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';
import 'package:hosta_app/data/models/user_model.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(110);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isDark = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    if (_isDark != isDark) {
      setState(() {
        _isDark = isDark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _isDark ? AppColors.dark : Colors.white,
      elevation: 0,
      flexibleSpace: Selector<AuthProvider, UserModel?>(
        selector: (context, provider) => provider.user,
        builder: (context, user, child) {
          return RepaintBoundary(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              child: Row(
                children: [
                  RepaintBoundary(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: user?.avatar != null
                          ? NetworkImage(user!.avatar!)
                          : null,
                      child: user?.avatar == null
                          ? Icon(
                              Icons.person,
                              size: 32,
                              color: _isDark ? AppColors.white : AppColors.dark,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RepaintBoundary(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.welcome ?? 'Hi!',
                            style: TextStyle(
                              fontSize: 16,
                              color: _isDark ? AppColors.white : AppColors.dark,
                              fontFamily: AppFonts.getFontFamily(
                                Localizations.localeOf(context),
                              ),
                            ),
                          ),
                          Text(
                            user?.name ??
                                (AppLocalizations.of(context)?.guest ??
                                    'Guest'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _isDark ? AppColors.white : AppColors.dark,
                              fontFamily: AppFonts.getFontFamily(
                                Localizations.localeOf(context),
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _AppBarIcon(
                    icon: 'assets/icons/chat.svg',
                    isDark: _isDark,
                    onPressed: () => Navigator.pushNamed(context, '/chats'),
                  ),
                  _AppBarIcon(
                    icon: 'assets/icons/notification.svg',
                    isDark: _isDark,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/notifications'),
                  ),
                  _AppBarIcon(
                    icon: 'assets/icons/heart.svg',
                    isDark: _isDark,
                    onPressed: () => Navigator.pushNamed(context, '/favorites'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppBarIcon extends StatelessWidget {
  final String icon;
  final bool isDark;
  final VoidCallback onPressed;

  const _AppBarIcon({
    required this.icon,
    required this.isDark,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: IconButton(
        icon: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isDark ? AppColors.white : AppColors.dark,
            BlendMode.srcIn,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

// AppBar للصفحات الأخرى (بدون صورة المستخدم واسمه، مع سهم الرجوع)
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const SimpleAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppColors.dark : AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          : null,
      centerTitle: title != null,
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
