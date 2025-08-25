import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/presentation/providers/feedback_provider.dart';

class ProviderFeedbackScreen extends StatefulWidget {
  final String providerId;
  final String bookingId;
  final String providerName;
  final String? providerImage;
  final String serviceTitle;

  const ProviderFeedbackScreen({
    super.key,
    required this.providerId,
    required this.bookingId,
    required this.providerName,
    this.providerImage,
    required this.serviceTitle,
  });

  @override
  State<ProviderFeedbackScreen> createState() => _ProviderFeedbackScreenState();
}

class _ProviderFeedbackScreenState extends State<ProviderFeedbackScreen> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  String _getRatingText(BuildContext context) {
    switch (_rating) {
      case 1:
        return AppLocalizations.of(context)?.rating_poor ?? '1 - Poor';
      case 2:
        return AppLocalizations.of(context)?.rating_fair ?? '2 - Fair';
      case 3:
        return AppLocalizations.of(context)?.rating_average ?? '3 - Average';
      case 4:
        return AppLocalizations.of(context)?.rating_good ?? '4 - Good';
      case 5:
        return AppLocalizations.of(context)?.rating_excellent ??
            '5 - Excellent';
      default:
        return '';
    }
  }

  Future<void> _handleSubmit() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.please_select_a_rating ??
                'Please select a rating',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final success = await context.read<FeedbackProvider>().submitFeedback(
        providerId: widget.providerId,
        bookingId: widget.bookingId,
        rating: _rating,
        comment: _feedbackController.text.trim(),
      );

      if (!success) {
        if (!mounted) return;
        final error = context.read<FeedbackProvider>().error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Failed to submit feedback'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!mounted) return;

      // Show success dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)?.thank_you ?? 'Thank You!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)?.your_feedback_helps_us_improve ??
                    'Your feedback helps us improve our services.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/home', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.done ?? 'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: SimpleAppBar(
        title:
            AppLocalizations.of(context)?.provider_feedback_page_title ??
            'تقييم المزود',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Provider Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.2).toInt())
                      : AppColors.boxBorder,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: widget.providerImage != null
                        ? NetworkImage(widget.providerImage!)
                        : null,
                    child: widget.providerImage == null
                        ? Icon(
                            Icons.person,
                            size: 30,
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
                          widget.providerName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.white : AppColors.dark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.serviceTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)?.how_would_you_rate_experience ??
                  'How would you rate the experience\nand service?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
            ),
            const SizedBox(height: 16),
            // Rating Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: index < _rating ? Colors.amber : Colors.grey,
                    size: 32,
                  ),
                );
              }),
            ),
            if (_rating > 0) ...[
              const SizedBox(height: 8),
              Text(
                _getRatingText(context),
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.white : AppColors.dark,
                ),
              ),
            ],
            const SizedBox(height: 24),
            // Feedback Text Field
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.2).toInt())
                      : AppColors.boxBorder,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(
                          context,
                        )?.additional_comments_optional ??
                        'Additional Comments (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _feedbackController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)?.share_your_experience ??
                          'Share your experience...',
                      hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.white.withAlpha((255 * 0.5).toInt())
                            : AppColors.dark.withAlpha((255 * 0.5).toInt()),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Help Text
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.dark.withAlpha((255 * 0.05).toInt())
                    : AppColors.primaryBlue.withAlpha((255 * 0.05).toInt()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)?.your_feedback_helps_improve ??
                        'Your feedback helps us improve our services and maintain high quality standards.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.7).toInt())
                          : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(
                          context,
                        )?.thank_you_for_choosing_hosta ??
                        'Thank you for choosing Hosta Services!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)?.submit ?? 'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
