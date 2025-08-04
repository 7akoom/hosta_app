import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/data/models/provider_model.dart';

class ProviderReviewsScreen extends StatefulWidget {
  final ProviderModel provider;

  const ProviderReviewsScreen({super.key, required this.provider});

  @override
  State<ProviderReviewsScreen> createState() => _ProviderReviewsScreenState();
}

class _ProviderReviewsScreenState extends State<ProviderReviewsScreen> {
  // Mock reviews data - in real app this would come from API
  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'userName': 'Ahmed Ali',
      'userAvatar': 'assets/images/logo.png',
      'rating': 5,
      'comment':
          'Great service! Very professional and on time. The quality of work exceeded my expectations. Highly recommended!',
      'date': '2024-01-15',
    },
    {
      'id': '2',
      'userName': 'Sarah Johnson',
      'userAvatar': 'assets/images/logo.png',
      'rating': 4,
      'comment':
          'Excellent work quality. The provider was very skilled and completed the job efficiently. Will definitely hire again!',
      'date': '2024-01-12',
    },
    {
      'id': '3',
      'userName': 'Mohammed Hassan',
      'userAvatar': 'assets/images/logo.png',
      'rating': 5,
      'comment':
          'Outstanding service! Very reliable and professional. The work was done perfectly and on schedule.',
      'date': '2024-01-10',
    },
    {
      'id': '4',
      'userName': 'Fatima Al-Zahra',
      'userAvatar': 'assets/images/logo.png',
      'rating': 4,
      'comment':
          'Good experience overall. The provider was punctual and the work quality was satisfactory.',
      'date': '2024-01-08',
    },
    {
      'id': '5',
      'userName': 'Omar Khalil',
      'userAvatar': 'assets/images/logo.png',
      'rating': 5,
      'comment':
          'Amazing service! Very professional, clean work, and reasonable pricing. Highly recommended!',
      'date': '2024-01-05',
    },
    {
      'id': '6',
      'userName': 'Layla Ahmed',
      'userAvatar': 'assets/images/logo.png',
      'rating': 4,
      'comment':
          'Very good service. The provider was knowledgeable and completed the work as promised.',
      'date': '2024-01-03',
    },
    {
      'id': '7',
      'userName': 'Youssef Ibrahim',
      'userAvatar': 'assets/images/logo.png',
      'rating': 5,
      'comment':
          'Excellent provider! Very professional, on time, and the work quality was outstanding.',
      'date': '2024-01-01',
    },
    {
      'id': '8',
      'userName': 'Aisha Mohammed',
      'userAvatar': 'assets/images/logo.png',
      'rating': 4,
      'comment':
          'Good service and reasonable price. The provider was friendly and professional.',
      'date': '2023-12-28',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const SimpleAppBar(),
      body: Column(
        children: [
          // Header Section
          _buildHeader(isDark),

          // Reviews List
          Expanded(child: _buildReviewsList(isDark)),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.05).toInt())
            : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? AppColors.white.withAlpha((255 * 0.1).toInt())
                : AppColors.boxBorder,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider Info
          Row(
            children: [
              // Provider Avatar
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  widget.provider.image ?? 'assets/images/logo.png',
                ),
              ),

              const SizedBox(width: 12),

              // Provider Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.provider.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.white : AppColors.dark,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          widget.provider.rating.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.white : AppColors.dark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${_reviews.length} reviews)',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReviewsList(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return _buildReviewItem(review, isDark);
      },
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.05).toInt())
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.1).toInt())
              : AppColors.boxBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Row(
            children: [
              // User Avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(review['userAvatar']),
              ),

              const SizedBox(width: 12),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.white : AppColors.dark,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      _formatDate(review['date']),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.white.withAlpha((255 * 0.5).toInt())
                            : AppColors.dark.withAlpha((255 * 0.5).toInt()),
                      ),
                    ),
                  ],
                ),
              ),

              // Rating Stars
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: index < review['rating']
                        ? Colors.amber
                        : Colors.grey,
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Review Comment
          Text(
            review['comment'],
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.8).toInt())
                  : AppColors.dark.withAlpha((255 * 0.8).toInt()),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString;
    }
  }
}
