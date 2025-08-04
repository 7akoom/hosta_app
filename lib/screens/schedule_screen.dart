import 'package:flutter/material.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<String> _availableTimes = [];
  String? _selectedTime;

  // قائمة الأوقات المتاحة
  final List<String> _defaultAvailableTimes = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '5:00 PM',
    '8:00 PM',
    '10:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    // عرض الأوقات المتاحة لليوم الحالي عند فتح الصفحة
    _availableTimes = _defaultAvailableTimes;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const SimpleAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // التقويم
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.1).toInt())
                      : AppColors.boxBorder,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 30)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableGestures: AvailableGestures.all,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 17,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.primaryBlue.withAlpha((255 * 0.3).toInt()),
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                  weekendTextStyle: TextStyle(
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedTime = null;

                    // عرض الأوقات المتاحة لليوم المحدد
                    // في الواقع، يمكن جلب هذه الأوقات من الباك إند حسب اليوم المحدد
                    _availableTimes = _defaultAvailableTimes;
                  });
                },
              ),
            ),

            // الأوقات المتاحة
            if (_availableTimes.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Available Times:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: _availableTimes.length,
                  itemBuilder: (context, index) {
                    final time = _availableTimes[index];
                    final isSelected = time == _selectedTime;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : isDark
                              ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : isDark
                                ? AppColors.white.withAlpha((255 * 0.1).toInt())
                                : AppColors.boxBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            time,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : isDark
                                  ? AppColors.white
                                  : AppColors.dark,
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // زر التأكيد
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _selectedTime != null
                      ? () {
                          // في التطبيق الحقيقي سيتم إرسال البيانات للباك إند
                          // وبعد نجاح العملية يتم التوجيه لصفحة My Services

                          // عرض رسالة نجاح
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking created successfully'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // الانتقال إلى صفحة My Services
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/my-services',
                            (route) => false, // إزالة كل الصفحات السابقة
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: isDark
                        ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                        : Colors.grey[300],
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            // ملاحظة الإلغاء
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.white : AppColors.dark,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Free Cancellation\n',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: 'Cancel before May 1st (5H) For full refund.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
