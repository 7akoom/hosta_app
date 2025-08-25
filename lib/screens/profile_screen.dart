import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/presentation/providers/auth_provider.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title:
            AppLocalizations.of(context)?.profile_page_title ?? 'الملف الشخصي',
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header - دائماً نعرض معلومات المستخدم
                if (user != null) ...[
                  _buildProfileHeader(context, user),
                  const SizedBox(height: 24),
                ],
                // Profile Options (available for both guests and users)
                _buildProfileOptions(context),
                const SizedBox(height: 24),
                // Account Actions (only for logged in users)
                if (user != null) _buildAccountActions(context, authProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, user) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.1).toInt())
            : AppColors.boxColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.2).toInt())
              : AppColors.boxBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: user.avatar != null
                    ? NetworkImage(user.avatar!)
                    : null,
                child: user.avatar == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: isDark ? AppColors.white : AppColors.dark,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: isDark ? AppColors.white : AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.white.withAlpha((255 * 0.7).toInt())
                            : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                      ),
                    ),
                    if (user.phone != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.phone!,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.white.withAlpha((255 * 0.7).toInt())
                              : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                        ),
                      ),
                    ],
                    if (user.city != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.city!,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.white.withAlpha(
                                      (255 * 0.7).toInt(),
                                    )
                                  : AppColors.dark.withAlpha(
                                      (255 * 0.7).toInt(),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = context.read<AuthProvider>().user;
    final options = [
      if (user != null)
        {
          'icon': Icons.person_outline,
          'title': AppLocalizations.of(context)?.account ?? 'Account',
          'subtitle':
              AppLocalizations.of(context)?.manage_account_information ??
              'Manage your account information',
          'onTap': () {
            Navigator.pushNamed(context, '/account');
          },
        },
      {
        'icon': Icons.settings_outlined,
        'title': AppLocalizations.of(context)?.settings ?? 'Settings',
        'subtitle':
            AppLocalizations.of(context)?.language_and_theme_preferences ??
            'Language and theme preferences',
        'onTap': () {
          Navigator.pushNamed(context, '/settings');
        },
      },
      {
        'icon': Icons.help_outline,
        'title':
            AppLocalizations.of(context)?.help_and_support ?? 'Help & Support',
        'subtitle':
            AppLocalizations.of(context)?.contact_us_for_assistance ??
            'Contact us for assistance',
        'onTap': () {
          Navigator.pushNamed(context, '/support');
        },
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.my_account ?? 'My Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? AppColors.white : AppColors.dark,
          ),
        ),
        const SizedBox(height: 16),
        ...options.map(
          (option) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? AppColors.white.withAlpha((255 * 0.2).toInt())
                    : AppColors.boxBorder,
                width: 1.0,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withAlpha((255 * 0.1).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  option['icon'] as IconData,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
              ),
              title: Text(
                option['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isDark ? AppColors.white : AppColors.dark,
                ),
              ),
              subtitle: Text(
                option['subtitle'] as String,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.7).toInt())
                      : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
              onTap: option['onTap'] as VoidCallback,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignOut(BuildContext context, AuthProvider authProvider) {
    // Get navigator state before async operations
    final navigator = Navigator.of(context);

    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.sign_out ?? 'Sign Out'),
        content: Text(
          AppLocalizations.of(context)?.are_you_sure_sign_out ??
              'Are you sure you want to sign out?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              AppLocalizations.of(context)?.sign_out ?? 'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ).then((shouldSignOut) {
      if (shouldSignOut == true) {
        // Use a separate method for sign out logic
        _performSignOut(authProvider, navigator);
      }
    });
  }

  Future<void> _performSignOut(
    AuthProvider authProvider,
    NavigatorState navigator,
  ) async {
    await authProvider.signOut();
    if (mounted) {
      navigator
        ..pop() // Close current screen
        ..pushNamedAndRemoveUntil('/signin', (route) => false);
    }
  }

  Widget _buildAccountActions(BuildContext context, AuthProvider authProvider) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = authProvider.user;
    final isMockUser = user?.id == 'mock_user_001';

    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.1).toInt())
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.2).toInt())
              : AppColors.boxBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          if (!isMockUser) ...[
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha((255 * 0.1).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.logout, color: Colors.red, size: 20),
              ),
              title: Text(
                AppLocalizations.of(context)?.sign_out ?? 'Sign Out',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              subtitle: Text(
                AppLocalizations.of(context)?.sign_out_of_your_account ??
                    'Sign out of your account',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.7).toInt())
                      : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                ),
              ),
              onTap: () => _handleSignOut(context, authProvider),
            ),
          ] else ...[
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withAlpha((255 * 0.1).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.login,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
              ),
              title: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.primaryBlue,
                ),
              ),
              subtitle: Text(
                'تسجيل الدخول لعرض معلومات حسابك الحقيقية',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.7).toInt())
                      : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ],
        ],
      ),
    );
  }
}
