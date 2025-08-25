import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/generated/app_localizations.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement API call to send support message
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      if (!mounted) return;

      // Show success dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            AppLocalizations.of(context)?.message_sent ?? 'Message Sent',
          ),
          content: Text(
            AppLocalizations.of(context)?.thank_you_contacting_us ??
                'Thank you for contacting us. We will get back to you soon.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to previous screen
              },
              child: Text(AppLocalizations.of(context)?.ok ?? 'OK'),
            ),
          ],
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
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: SimpleAppBar(
        title:
            AppLocalizations.of(context)?.help_support_page_title ??
            'المساعدة والدعم',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.help_support ?? 'Help & Support',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)?.how_can_we_help_you ??
                  'How can we help you?',
              style: TextStyle(
                color: isDark
                    ? AppColors.white.withAlpha((255 * 0.7).toInt())
                    : AppColors.dark.withAlpha((255 * 0.7).toInt()),
              ),
            ),
            const SizedBox(height: 24),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)?.subject ?? 'Subject',
                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.what_is_your_issue_about ??
                            'What is your issue about?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(
                                context,
                              )?.please_enter_a_subject ??
                              'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)?.message ?? 'Message',
                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.describe_your_issue_in_detail ??
                            'Describe your issue in detail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(
                                context,
                              )?.please_enter_your_message ??
                              'Please enter your message';
                        }
                        if (value.trim().length < 10) {
                          return AppLocalizations.of(
                                context,
                              )?.message_must_be_at_least_10_characters ??
                              'Message must be at least 10 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
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
                                AppLocalizations.of(context)?.send_message ??
                                    'Send Message',
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                    AppLocalizations.of(context)?.contact_information ??
                        'Contact Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactInfo(
                    context,
                    Icons.email_outlined,
                    AppLocalizations.of(context)?.email ?? 'Email',
                    AppLocalizations.of(context)?.support_email ??
                        'support@hosta.com',
                    isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildContactInfo(
                    context,
                    Icons.phone_outlined,
                    AppLocalizations.of(context)?.phone ?? 'Phone',
                    AppLocalizations.of(context)?.support_phone ??
                        '+1 234 567 890',
                    isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withAlpha((255 * 0.1).toInt()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.white.withAlpha((255 * 0.7).toInt())
                    : AppColors.dark.withAlpha((255 * 0.7).toInt()),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
