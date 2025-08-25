import 'package:flutter/material.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;

class CancelBookingScreen extends StatefulWidget {
  final String bookingId;

  const CancelBookingScreen({super.key, required this.bookingId});

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  Future<void> _handleCancellation(BuildContext context) async {
    final navigator = Navigator.of(context);

    // عرض مؤشر التحميل
    if (!context.mounted) return;
    final loadingContext = context;
    showDialog(
      context: loadingContext,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // محاكاة الاتصال بالباك إند
    await Future.delayed(const Duration(seconds: 2));

    // إخفاء مؤشر التحميل
    if (!loadingContext.mounted) return;
    navigator.pop();

    final reason = _selectedReason == 'Other'
        ? _otherReasonController.text
        : _selectedReason;

    if (!mounted) return;

    // عرض رسالة النجاح
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
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
              AppLocalizations.of(context)?.booking_cancelled_successfully ??
                  'Booking Cancelled Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${AppLocalizations.of(context)?.reason ?? 'Reason'}: $reason',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  navigator.pop(); // إغلاق الـ dialog
                  navigator.pop(); // العودة إلى صفحة My Services
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
  }

  List<String> _getCancellationReasons(BuildContext context) {
    return [
      AppLocalizations.of(context)?.provider_not_available ??
          'Provider not available',
      AppLocalizations.of(context)?.change_of_plans ?? 'Change of plans',
      AppLocalizations.of(context)?.found_another_provider ??
          'Found another provider',
      AppLocalizations.of(context)?.price_too_high ?? 'Price too high',
      AppLocalizations.of(context)?.emergency ?? 'Emergency',
      AppLocalizations.of(context)?.other ?? 'Other',
    ];
  }

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: SimpleAppBar(
        title:
            AppLocalizations.of(context)?.cancel_booking_page_title ??
            'إلغاء الحجز',
      ),
      body: SingleChildScrollView(
        // تجنب تداخل لوحة المفاتيح مع المحتوى
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Icon(Icons.cancel_outlined, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(
                      context,
                    )?.please_pick_reason_for_cancellation ??
                    'Please Pick A Reason for Cancellation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.dark,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark
                        ? AppColors.white.withAlpha((255 * 0.1).toInt())
                        : AppColors.dark.withAlpha((255 * 0.1).toInt()),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedReason,
                  isExpanded: true,
                  hint: Text(
                    AppLocalizations.of(context)?.select_a_reason ??
                        'Select a reason',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.7).toInt())
                          : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                  underline: const SizedBox(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                  items: _getCancellationReasons(context).map((String reason) {
                    return DropdownMenuItem<String>(
                      value: reason,
                      child: Text(
                        reason,
                        style: TextStyle(
                          color: isDark ? AppColors.white : AppColors.dark,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedReason = value;
                      if (value != 'Other') {
                        _otherReasonController.clear();
                      }
                    });
                    // تحديث الحالة عند تغيير النص في حقل Other
                    if (value == 'Other') {
                      _otherReasonController.addListener(() {
                        setState(() {});
                      });
                    }
                  },
                ),
              ),
              if (_selectedReason == 'Other') ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _otherReasonController,
                  maxLines: null, // السماح بتعدد السطور
                  minLines: 3, // الحد الأدنى للسطور
                  textAlignVertical:
                      TextAlignVertical.top, // محاذاة النص للأعلى
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(
                          context,
                        )?.please_specify_your_reason ??
                        'Please specify your reason',
                    hintStyle: TextStyle(
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.5).toInt())
                          : AppColors.dark.withAlpha((255 * 0.5).toInt()),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      (_selectedReason == null ||
                          (_selectedReason == 'Other' &&
                              _otherReasonController.text.trim().isEmpty))
                      ? null
                      : () => _handleCancellation(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.cancel ?? 'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
