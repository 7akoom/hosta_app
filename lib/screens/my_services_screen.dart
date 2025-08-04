import 'package:flutter/material.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/theme/app_colors.dart';
import 'package:intl/intl.dart';

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'in_progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'in_progress':
        return 'In Progress';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // بيانات تجريبية (في التطبيق الحقيقي ستأتي من الباك إند)
    final bookings = [
      {
        'id': '234455',
        'serviceName': 'Gardening',
        'date': DateTime.now().add(const Duration(days: 2)),
        'price': 300,
        'status': 'pending',
      },
      {
        'id': '234456',
        'serviceName': 'Gardening',
        'date': DateTime.now().add(const Duration(days: 5)),
        'price': 300,
        'status': 'pending',
      },
    ];

    return Scaffold(
      appBar: const SimpleAppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final bookingDate = booking['date'] as DateTime;
          final canCancel = bookingDate.difference(DateTime.now()).inHours > 5;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? AppColors.white.withAlpha((255 * 0.1).toInt())
                    : AppColors.boxBorder,
              ),
            ),
            child: Column(
              children: [
                // معلومات الحجز
                Row(
                  children: [
                    // رقم الحجز والخدمة
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service ID',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.white.withAlpha(
                                      (255 * 0.7).toInt(),
                                    )
                                  : AppColors.dark.withAlpha(
                                      (255 * 0.7).toInt(),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '#${booking['id']}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.white : AppColors.dark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            booking['serviceName'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.white : AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // التاريخ والوقت
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Date & Time',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('MMM dd, yyyy').format(bookingDate),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.white : AppColors.dark,
                          ),
                        ),
                        Text(
                          DateFormat('h:mm a').format(bookingDate),
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.white : AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // صورة المزود والسعر وزر الإلغاء
                Row(
                  children: [
                    // صورة المزود
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.dark.withAlpha((255 * 0.3).toInt())
                            : Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 16),
                    // السعر والحالة
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                        ),
                        Text(
                          '\$${booking['price']}-\$${(booking['price'] as int) + 80}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              booking['status'] as String,
                            ).withAlpha((255 * 0.1).toInt()),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getStatusText(booking['status'] as String),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(
                                booking['status'] as String,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // زر الإلغاء
                    if (booking['status'] == 'pending')
                      TextButton(
                        onPressed: canCancel
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  '/cancel-booking',
                                  arguments: {'bookingId': booking['id']},
                                );
                              }
                            : null,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withAlpha(
                            (255 * 0.1).toInt(),
                          ),
                          foregroundColor: Colors.red,
                          disabledForegroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
