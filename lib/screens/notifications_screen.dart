import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/routes/app_routes.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/presentation/providers/notification_provider.dart';
import 'package:hosta_app/data/models/notification_model.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // إضافة مستمع للتمرير للتحميل المزيد
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // جلب الإشعارات عند فتح الشاشة
    if (mounted) {
      final provider = context.read<NotificationProvider>();
      Future.microtask(() {
        if (mounted) {
          provider.fetchNotifications();
        }
      });
    }
  }

  Future<void> _refreshNotifications() async {
    if (!mounted) return;
    final provider = context.read<NotificationProvider>();
    await provider.fetchNotifications(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final provider = context.read<NotificationProvider>();
      provider.fetchNotifications();
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  Widget _buildNotificationMessage(
    NotificationModel notification,
    bool isDark,
  ) {
    if (notification.type == 'booking_started') {
      final message = notification.message;
      final providerNameMatch = RegExp(
        r'Provider (.*?) is',
      ).firstMatch(message);
      if (providerNameMatch != null) {
        final beforeName = message.substring(0, providerNameMatch.start);
        final providerName = providerNameMatch.group(1)!;
        final afterName = message.substring(
          providerNameMatch.start + 9 + providerName.length,
        );

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.7).toInt())
                  : AppColors.dark.withAlpha((255 * 0.7).toInt()),
            ),
            children: [
              TextSpan(text: beforeName),
              TextSpan(
                text: providerName,
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: afterName),
            ],
          ),
        );
      }
    } else if (notification.type == 'booking_cancelled') {
      final message = notification.message;
      final bookingNumberMatch = RegExp(r'#(\d+)').firstMatch(message);
      if (bookingNumberMatch != null) {
        final beforeNumber = message.substring(0, bookingNumberMatch.start);
        final bookingNumber = bookingNumberMatch.group(0)!;
        final afterNumber = message.substring(bookingNumberMatch.end);

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.7).toInt())
                  : AppColors.dark.withAlpha((255 * 0.7).toInt()),
            ),
            children: [
              TextSpan(text: beforeNumber),
              TextSpan(
                text: bookingNumber,
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: afterNumber),
            ],
          ),
        );
      }
    } else if (notification.type == 'booking_rejected') {
      final message = notification.message;
      final bookingNumberMatch = RegExp(r'#(\d+)').firstMatch(message);
      if (bookingNumberMatch != null) {
        final beforeNumber = message.substring(0, bookingNumberMatch.start);
        final bookingNumber = bookingNumberMatch.group(0)!;
        final afterNumber = message.substring(bookingNumberMatch.end);

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.7).toInt())
                  : AppColors.dark.withAlpha((255 * 0.7).toInt()),
            ),
            children: [
              TextSpan(text: beforeNumber),
              TextSpan(
                text: bookingNumber,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: afterNumber),
            ],
          ),
        );
      }
    } else if (notification.type == 'service_completed') {
      final message = notification.message;
      final bookingNumberMatch = RegExp(r'#(\d+)').firstMatch(message);
      if (bookingNumberMatch != null) {
        final beforeNumber = message.substring(0, bookingNumberMatch.start);
        final bookingNumber = bookingNumberMatch.group(0)!;
        final afterNumber = message.substring(bookingNumberMatch.end);

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.7).toInt())
                  : AppColors.dark.withAlpha((255 * 0.7).toInt()),
            ),
            children: [
              TextSpan(text: beforeNumber),
              TextSpan(
                text: bookingNumber,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: afterNumber),
            ],
          ),
        );
      }
    } else if (notification.type == 'booking_confirmation') {
      final message = notification.message;
      final bookingNumberMatch = RegExp(r'#(\d+)').firstMatch(message);
      if (bookingNumberMatch != null) {
        final beforeNumber = message.substring(0, bookingNumberMatch.start);
        final bookingNumber = bookingNumberMatch.group(0)!;
        final afterNumber = message.substring(bookingNumberMatch.end);

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.7).toInt())
                  : AppColors.dark.withAlpha((255 * 0.7).toInt()),
            ),
            children: [
              TextSpan(text: beforeNumber),
              TextSpan(
                text: bookingNumber,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: afterNumber),
            ],
          ),
        );
      }
    }

    return Text(
      notification.message,
      style: TextStyle(
        fontSize: 14,
        color: isDark
            ? AppColors.white.withAlpha((255 * 0.7).toInt())
            : AppColors.dark.withAlpha((255 * 0.7).toInt()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: SimpleAppBar(
        title:
            AppLocalizations.of(context)?.notifications_page_title ??
            'الإشعارات',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.notifications ??
                      'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    if (!mounted) return;
                    final provider = context.read<NotificationProvider>();
                    provider.markAllAsRead();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                  ),
                  icon: const Icon(Icons.done_all),
                  label: Text(
                    AppLocalizations.of(context)?.mark_all_as_read ??
                        'Mark all as read',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<NotificationProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.notifications.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null && provider.notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(provider.error!),
                        TextButton(
                          onPressed: () {
                            provider.resetError();
                            _refreshNotifications();
                          },
                          child: Text(
                            AppLocalizations.of(context)?.try_again ??
                                'Try Again',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.notifications.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)?.no_notifications_yet ??
                          'No notifications yet',
                      style: TextStyle(
                        color: isDark ? AppColors.white : AppColors.dark,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refreshNotifications,
                  child: ListView.custom(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (!mounted) return null;

                        if (index == provider.notifications.length) {
                          if (provider.isLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }

                        final notification = provider.notifications[index];

                        return RepaintBoundary(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Dismissible(
                              key: Key(notification.id),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) {
                                provider.deleteNotification(notification.id);
                              },
                              child: GestureDetector(
                                onTap: () {
                                  if (!notification.isRead) {
                                    if (mounted) {
                                      provider.markAsRead(notification.id);
                                    }
                                  }
                                  if (mounted &&
                                      notification.type ==
                                          'service_completed' &&
                                      notification.data != null) {
                                    final navigator = Navigator.of(context);
                                    navigator.pushNamed(
                                      AppRoutes.confirmPayment,
                                      arguments: {
                                        'bookingId':
                                            notification.data!['booking_id'],
                                        'providerName':
                                            notification.data!['provider_name'],
                                        'amount': notification.data!['amount'],
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.dark.withAlpha(
                                            (255 * 0.1).toInt(),
                                          )
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDark
                                          ? AppColors.white.withAlpha(
                                              (255 * 0.1).toInt(),
                                            )
                                          : AppColors.boxBorder,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    notification.title,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isDark
                                                          ? AppColors.white
                                                          : AppColors.dark,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                if (!notification.isRead)
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          left: 8,
                                                        ),
                                                    width: 8,
                                                    height: 8,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: AppColors
                                                              .primaryBlue,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                  ),
                                                const Spacer(),
                                                Text(
                                                  _getTimeAgo(
                                                    notification.createdAt,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDark
                                                        ? AppColors.white
                                                              .withAlpha(
                                                                (255 * 0.7)
                                                                    .toInt(),
                                                              )
                                                        : AppColors.dark
                                                              .withAlpha(
                                                                (255 * 0.7)
                                                                    .toInt(),
                                                              ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            _buildNotificationMessage(
                                              notification,
                                              isDark,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: provider.notifications.length + 1,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: true,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
