# دليل عناوين AppBar

## الشاشات التي تم إضافة العناوين لها

### ✅ **الشاشات الداخلية (مع العناوين):**

1. **الملف الشخصي** - `الملف الشخصي` / `Profile` / `پڕۆفایل`
2. **المفضلة** - `المفضلة` / `Favorites` / `دڵخۆشەکان`
3. **البحث** - `البحث` / `Search` / `گەڕان`
4. **الإعدادات** - `الإعدادات` / `Settings` / `ڕێکخستنەکان`
5. **الحساب** - `الحساب` / `Account` / `هەژمار`
6. **الإشعارات** - `الإشعارات` / `Notifications` / `ئاگادارکردنەوەکان`
7. **المحادثات** - `المحادثات` / `Chats` / `چاتەکان`
8. **خدماتي** - `خدماتي` / `My Services` / `خزمەتگوزارییەکانم`
9. **المساعدة والدعم** - `المساعدة والدعم` / `Help & Support` / `یارمەتی و پشتگیری`
10. **حجز الخدمة** - `حجز الخدمة` / `Book Service` / `داواکردنی خزمەتگوزاری`
11. **الجدول الزمني** - `الجدول الزمني` / `Schedule` / `کاتیار`
12. **تأكيد الدفع** - `تأكيد الدفع` / `Confirm Payment` / `پشتڕاستکردنەوەی پارەدان`
13. **إلغاء الحجز** - `إلغاء الحجز` / `Cancel Booking` / `هەڵوەشاندنەوەی داواکردن`
14. **تفاصيل المزود** - `تفاصيل المزود` / `Provider Details` / `وردەکارییەکانی دابینکەر`
15. **تفاصيل الخدمة** - `تفاصيل الخدمة` / `Service Details` / `وردەکارییەکانی خزمەتگوزاری`
16. **تفاصيل الفئة** - `تفاصيل الفئة` / `Category Details` / `وردەکارییەکانی پۆل`
17. **تقييم المزود** - `تقييم المزود` / `Provider Feedback` / `ڕەخنی دابینکەر`
18. **تقييمات المزود** - `تقييمات المزود` / `Provider Reviews` / `ڕەخنەکانی دابینکەر`

### ❌ **الشاشات التي لم يتم إضافة العناوين لها:**

1. **الشاشة الرئيسية** - تستخدم CustomAppBar (بدون عنوان)
2. **شاشات التسجيل** - شاشات خارجية
3. **شاشة تسجيل الدخول** - شاشة خارجية
4. **شاشة استرجاع كلمة المرور** - شاشة خارجية
5. **شاشة الترحيب** - شاشة خارجية

## التعديلات المطبقة

### 1. تعديل SimpleAppBar
```dart
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  
  const SimpleAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // ... باقي الخصائص
      title: title != null ? Text(
        title!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ) : null,
      centerTitle: title != null,
      // ... باقي المحتوى
    );
  }
}
```

### 2. إضافة الترجمات
تم إضافة الترجمات التالية إلى ملفات الترجمة:

#### ملف الترجمة الإنجليزية (`app_en.arb`):
```json
{
  "profile_page_title": "Profile",
  "favorites_page_title": "Favorites",
  "search_page_title": "Search",
  "settings_page_title": "Settings",
  "account_page_title": "Account",
  "notifications_page_title": "Notifications",
  "chats_page_title": "Chats",
  "my_services_page_title": "My Services",
  "help_support_page_title": "Help & Support",
  "book_service_page_title": "Book Service",
  "schedule_page_title": "Schedule",
  "confirm_payment_page_title": "Confirm Payment",
  "cancel_booking_page_title": "Cancel Booking",
  "provider_details_page_title": "Provider Details",
  "service_details_page_title": "Service Details",
  "category_details_page_title": "Category Details",
  "provider_feedback_page_title": "Provider Feedback",
  "provider_reviews_page_title": "Provider Reviews"
}
```

#### ملف الترجمة العربية (`app_ar.arb`):
```json
{
  "profile_page_title": "الملف الشخصي",
  "favorites_page_title": "المفضلة",
  "search_page_title": "البحث",
  "settings_page_title": "الإعدادات",
  "account_page_title": "الحساب",
  "notifications_page_title": "الإشعارات",
  "chats_page_title": "المحادثات",
  "my_services_page_title": "خدماتي",
  "help_support_page_title": "المساعدة والدعم",
  "book_service_page_title": "حجز الخدمة",
  "schedule_page_title": "الجدول الزمني",
  "confirm_payment_page_title": "تأكيد الدفع",
  "cancel_booking_page_title": "إلغاء الحجز",
  "provider_details_page_title": "تفاصيل المزود",
  "service_details_page_title": "تفاصيل الخدمة",
  "category_details_page_title": "تفاصيل الفئة",
  "provider_feedback_page_title": "تقييم المزود",
  "provider_reviews_page_title": "تقييمات المزود"
}
```

#### ملف الترجمة الكردية (`app_ku.arb`):
```json
{
  "profile_page_title": "پڕۆفایل",
  "favorites_page_title": "دڵخۆشەکان",
  "search_page_title": "گەڕان",
  "settings_page_title": "ڕێکخستنەکان",
  "account_page_title": "هەژمار",
  "notifications_page_title": "ئاگادارکردنەوەکان",
  "chats_page_title": "چاتەکان",
  "my_services_page_title": "خزمەتگوزارییەکانم",
  "help_support_page_title": "یارمەتی و پشتگیری",
  "book_service_page_title": "داواکردنی خزمەتگوزاری",
  "schedule_page_title": "کاتیار",
  "confirm_payment_page_title": "پشتڕاستکردنەوەی پارەدان",
  "cancel_booking_page_title": "هەڵوەشاندنەوەی داواکردن",
  "provider_details_page_title": "وردەکارییەکانی دابینکەر",
  "service_details_page_title": "وردەکارییەکانی خزمەتگوزاری",
  "category_details_page_title": "وردەکارییەکانی پۆل",
  "provider_feedback_page_title": "ڕەخنی دابینکەر",
  "provider_reviews_page_title": "ڕەخنەکانی دابینکەر"
}
```

### 3. استخدام الترجمات في الشاشات
```dart
// قبل التعديل
appBar: const SimpleAppBar(title: 'اسم الشاشة'),

// بعد التعديل
appBar: SimpleAppBar(title: AppLocalizations.of(context)?.profile_page_title ?? 'الملف الشخصي'),
```

## مزايا إضافة العناوين والترجمات

### ✅ **الفوائد:**
1. **وضوح التنقل** - المستخدم يعرف في أي شاشة هو
2. **تجربة مستخدم أفضل** - واجهة أكثر وضوحاً
3. **سهولة الاستخدام** - خاصة للمستخدمين الجدد
4. **اتساق التصميم** - جميع الشاشات الداخلية لها عناوين
5. **دعم متعدد اللغات** - العناوين تظهر باللغة المختارة
6. **سهولة الصيانة** - تغيير العناوين من ملف واحد

### 🎨 **التصميم:**
- **العنوان**: عربي/إنجليزي/كردي، خط عريض، حجم 18
- **الموقع**: في المنتصف عند وجود عنوان
- **اللون**: أبيض على خلفية زرقاء
- **التوافق**: مع الوضع المظلم والفاتح
- **الترجمة**: تلقائية حسب لغة التطبيق

## كيفية إضافة عنوان لشاشة جديدة

### 1. للشاشات الداخلية:
```dart
// أضف الترجمة إلى ملفات الترجمة
"new_page_title": "عنوان الشاشة الجديدة"

// استخدم الترجمة في الشاشة
appBar: SimpleAppBar(title: AppLocalizations.of(context)?.new_page_title ?? 'عنوان الشاشة الجديدة'),
```

### 2. للشاشات الخارجية:
```dart
appBar: const SimpleAppBar(), // بدون عنوان
```

### 3. للشاشة الرئيسية:
```dart
appBar: const CustomAppBar(), // AppBar مخصص
```

## نصائح لاختيار العناوين

### ✅ **أفضل الممارسات:**
1. **استخدم العربية** - لسهولة القراءة
2. **اختر أسماء قصيرة** - تناسب عرض الشاشة
3. **كن واضحاً** - وصف دقيق لمحتوى الشاشة
4. **حافظ على الاتساق** - نفس نمط التسمية
5. **أضف الترجمات** - لجميع اللغات المدعومة

### ❌ **تجنب:**
1. **العناوين الطويلة** - قد لا تظهر بشكل كامل
2. **الأسماء التقنية** - استخدم أسماء مفهومة للمستخدم
3. **العناوين المكررة** - كل شاشة لها عنوان فريد
4. **نسيان الترجمات** - تأكد من إضافة جميع اللغات

## الشاشات المتبقية

إذا أردت إضافة عناوين لشاشات أخرى في المستقبل:

1. **شاشة الدردشة** - `المحادثة` / `Chat` / `چات`
2. **شاشة الدفع** - `الدفع` / `Payment` / `پارەدان`
3. **شاشة التأكيد** - `تأكيد الطلب` / `Confirm Order` / `پشتڕاستکردنەوەی داواکردن`
4. **شاشة التاريخ** - `سجل الطلبات` / `Order History` / `مێژووی داواکردنەکان`

## الخلاصة

تم إضافة عناوين واضحة ومفهومة لجميع الشاشات الداخلية مع دعم كامل للترجمة باللغات الثلاث (العربية، الإنجليزية، الكردية)، مما يحسن تجربة المستخدم ويجعل التنقل في التطبيق أكثر وضوحاً وسهولة.

## الشاشات التي تم إضافة العناوين لها

### ✅ **الشاشات الداخلية (مع العناوين):**

1. **الملف الشخصي** - `الملف الشخصي` / `Profile` / `پڕۆفایل`
2. **المفضلة** - `المفضلة` / `Favorites` / `دڵخۆشەکان`
3. **البحث** - `البحث` / `Search` / `گەڕان`
4. **الإعدادات** - `الإعدادات` / `Settings` / `ڕێکخستنەکان`
5. **الحساب** - `الحساب` / `Account` / `هەژمار`
6. **الإشعارات** - `الإشعارات` / `Notifications` / `ئاگادارکردنەوەکان`
7. **المحادثات** - `المحادثات` / `Chats` / `چاتەکان`
8. **خدماتي** - `خدماتي` / `My Services` / `خزمەتگوزارییەکانم`
9. **المساعدة والدعم** - `المساعدة والدعم` / `Help & Support` / `یارمەتی و پشتگیری`
10. **حجز الخدمة** - `حجز الخدمة` / `Book Service` / `داواکردنی خزمەتگوزاری`
11. **الجدول الزمني** - `الجدول الزمني` / `Schedule` / `کاتیار`
12. **تأكيد الدفع** - `تأكيد الدفع` / `Confirm Payment` / `پشتڕاستکردنەوەی پارەدان`
13. **إلغاء الحجز** - `إلغاء الحجز` / `Cancel Booking` / `هەڵوەشاندنەوەی داواکردن`
14. **تفاصيل المزود** - `تفاصيل المزود` / `Provider Details` / `وردەکارییەکانی دابینکەر`
15. **تفاصيل الخدمة** - `تفاصيل الخدمة` / `Service Details` / `وردەکارییەکانی خزمەتگوزاری`
16. **تفاصيل الفئة** - `تفاصيل الفئة` / `Category Details` / `وردەکارییەکانی پۆل`
17. **تقييم المزود** - `تقييم المزود` / `Provider Feedback` / `ڕەخنی دابینکەر`
18. **تقييمات المزود** - `تقييمات المزود` / `Provider Reviews` / `ڕەخنەکانی دابینکەر`

### ❌ **الشاشات التي لم يتم إضافة العناوين لها:**

1. **الشاشة الرئيسية** - تستخدم CustomAppBar (بدون عنوان)
2. **شاشات التسجيل** - شاشات خارجية
3. **شاشة تسجيل الدخول** - شاشة خارجية
4. **شاشة استرجاع كلمة المرور** - شاشة خارجية
5. **شاشة الترحيب** - شاشة خارجية

## التعديلات المطبقة

### 1. تعديل SimpleAppBar
```dart
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  
  const SimpleAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // ... باقي الخصائص
      title: title != null ? Text(
        title!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ) : null,
      centerTitle: title != null,
      // ... باقي المحتوى
    );
  }
}
```

### 2. إضافة الترجمات
تم إضافة الترجمات التالية إلى ملفات الترجمة:

#### ملف الترجمة الإنجليزية (`app_en.arb`):
```json
{
  "profile_page_title": "Profile",
  "favorites_page_title": "Favorites",
  "search_page_title": "Search",
  "settings_page_title": "Settings",
  "account_page_title": "Account",
  "notifications_page_title": "Notifications",
  "chats_page_title": "Chats",
  "my_services_page_title": "My Services",
  "help_support_page_title": "Help & Support",
  "book_service_page_title": "Book Service",
  "schedule_page_title": "Schedule",
  "confirm_payment_page_title": "Confirm Payment",
  "cancel_booking_page_title": "Cancel Booking",
  "provider_details_page_title": "Provider Details",
  "service_details_page_title": "Service Details",
  "category_details_page_title": "Category Details",
  "provider_feedback_page_title": "Provider Feedback",
  "provider_reviews_page_title": "Provider Reviews"
}
```

#### ملف الترجمة العربية (`app_ar.arb`):
```json
{
  "profile_page_title": "الملف الشخصي",
  "favorites_page_title": "المفضلة",
  "search_page_title": "البحث",
  "settings_page_title": "الإعدادات",
  "account_page_title": "الحساب",
  "notifications_page_title": "الإشعارات",
  "chats_page_title": "المحادثات",
  "my_services_page_title": "خدماتي",
  "help_support_page_title": "المساعدة والدعم",
  "book_service_page_title": "حجز الخدمة",
  "schedule_page_title": "الجدول الزمني",
  "confirm_payment_page_title": "تأكيد الدفع",
  "cancel_booking_page_title": "إلغاء الحجز",
  "provider_details_page_title": "تفاصيل المزود",
  "service_details_page_title": "تفاصيل الخدمة",
  "category_details_page_title": "تفاصيل الفئة",
  "provider_feedback_page_title": "تقييم المزود",
  "provider_reviews_page_title": "تقييمات المزود"
}
```

#### ملف الترجمة الكردية (`app_ku.arb`):
```json
{
  "profile_page_title": "پڕۆفایل",
  "favorites_page_title": "دڵخۆشەکان",
  "search_page_title": "گەڕان",
  "settings_page_title": "ڕێکخستنەکان",
  "account_page_title": "هەژمار",
  "notifications_page_title": "ئاگادارکردنەوەکان",
  "chats_page_title": "چاتەکان",
  "my_services_page_title": "خزمەتگوزارییەکانم",
  "help_support_page_title": "یارمەتی و پشتگیری",
  "book_service_page_title": "داواکردنی خزمەتگوزاری",
  "schedule_page_title": "کاتیار",
  "confirm_payment_page_title": "پشتڕاستکردنەوەی پارەدان",
  "cancel_booking_page_title": "هەڵوەشاندنەوەی داواکردن",
  "provider_details_page_title": "وردەکارییەکانی دابینکەر",
  "service_details_page_title": "وردەکارییەکانی خزمەتگوزاری",
  "category_details_page_title": "وردەکارییەکانی پۆل",
  "provider_feedback_page_title": "ڕەخنی دابینکەر",
  "provider_reviews_page_title": "ڕەخنەکانی دابینکەر"
}
```

### 3. استخدام الترجمات في الشاشات
```dart
// قبل التعديل
appBar: const SimpleAppBar(title: 'اسم الشاشة'),

// بعد التعديل
appBar: SimpleAppBar(title: AppLocalizations.of(context)?.profile_page_title ?? 'الملف الشخصي'),
```

## مزايا إضافة العناوين والترجمات

### ✅ **الفوائد:**
1. **وضوح التنقل** - المستخدم يعرف في أي شاشة هو
2. **تجربة مستخدم أفضل** - واجهة أكثر وضوحاً
3. **سهولة الاستخدام** - خاصة للمستخدمين الجدد
4. **اتساق التصميم** - جميع الشاشات الداخلية لها عناوين
5. **دعم متعدد اللغات** - العناوين تظهر باللغة المختارة
6. **سهولة الصيانة** - تغيير العناوين من ملف واحد

### 🎨 **التصميم:**
- **العنوان**: عربي/إنجليزي/كردي، خط عريض، حجم 18
- **الموقع**: في المنتصف عند وجود عنوان
- **اللون**: أبيض على خلفية زرقاء
- **التوافق**: مع الوضع المظلم والفاتح
- **الترجمة**: تلقائية حسب لغة التطبيق

## كيفية إضافة عنوان لشاشة جديدة

### 1. للشاشات الداخلية:
```dart
// أضف الترجمة إلى ملفات الترجمة
"new_page_title": "عنوان الشاشة الجديدة"

// استخدم الترجمة في الشاشة
appBar: SimpleAppBar(title: AppLocalizations.of(context)?.new_page_title ?? 'عنوان الشاشة الجديدة'),
```

### 2. للشاشات الخارجية:
```dart
appBar: const SimpleAppBar(), // بدون عنوان
```

### 3. للشاشة الرئيسية:
```dart
appBar: const CustomAppBar(), // AppBar مخصص
```

## نصائح لاختيار العناوين

### ✅ **أفضل الممارسات:**
1. **استخدم العربية** - لسهولة القراءة
2. **اختر أسماء قصيرة** - تناسب عرض الشاشة
3. **كن واضحاً** - وصف دقيق لمحتوى الشاشة
4. **حافظ على الاتساق** - نفس نمط التسمية
5. **أضف الترجمات** - لجميع اللغات المدعومة

### ❌ **تجنب:**
1. **العناوين الطويلة** - قد لا تظهر بشكل كامل
2. **الأسماء التقنية** - استخدم أسماء مفهومة للمستخدم
3. **العناوين المكررة** - كل شاشة لها عنوان فريد
4. **نسيان الترجمات** - تأكد من إضافة جميع اللغات

## الشاشات المتبقية

إذا أردت إضافة عناوين لشاشات أخرى في المستقبل:

1. **شاشة الدردشة** - `المحادثة` / `Chat` / `چات`
2. **شاشة الدفع** - `الدفع` / `Payment` / `پارەدان`
3. **شاشة التأكيد** - `تأكيد الطلب` / `Confirm Order` / `پشتڕاستکردنەوەی داواکردن`
4. **شاشة التاريخ** - `سجل الطلبات` / `Order History` / `مێژووی داواکردنەکان`

## الخلاصة

تم إضافة عناوين واضحة ومفهومة لجميع الشاشات الداخلية مع دعم كامل للترجمة باللغات الثلاث (العربية، الإنجليزية، الكردية)، مما يحسن تجربة المستخدم ويجعل التنقل في التطبيق أكثر وضوحاً وسهولة.
