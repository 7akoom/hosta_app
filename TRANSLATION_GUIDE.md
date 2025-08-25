# دليل إضافة الترجمة في باقي الصفحات

## نظرة عامة

هذا الدليل سيعلمك كيفية إضافة الترجمة في جميع صفحات التطبيق خطوة بخطوة.

## الخطوات الأساسية لإضافة الترجمة

### 1. إضافة Import

في بداية كل ملف Dart، أضف:

```dart
import 'package:hosta_app/generated/app_localizations.dart';
```

### 2. استبدال النصوص الثابتة

استبدل جميع النصوص الثابتة (Hardcoded strings) بـ:

```dart
// بدلاً من
Text("Hello World")

// استخدم
Text(AppLocalizations.of(context)?.hello_world ?? 'Hello World')
```

### 3. استخدام النصوص المترجمة

#### النصوص الأساسية
```dart
// العناوين
AppBar(
  title: Text(AppLocalizations.of(context)?.home ?? 'Home'),
)

// الأزرار
ElevatedButton(
  onPressed: () {},
  child: Text(AppLocalizations.of(context)?.save ?? 'Save'),
)

// رسائل الخطأ
Text(AppLocalizations.of(context)?.error_occurred ?? 'An error occurred')

// رسائل النجاح
Text(AppLocalizations.of(context)?.payment_successful ?? 'Payment Successful')
```

## أمثلة عملية

### مثال 1: صفحة تسجيل الدخول

```dart
// قبل الترجمة
Text("Sign in with your email or phone number")
Text("Email or Mobile number")
Text("Password")
Text("Forgot Password?")
Text("Sign in")
Text("Don't have an account?")
Text("Signup")

// بعد الترجمة
Text(AppLocalizations.of(context)?.sign_in ?? "Sign in with your email or phone number")
Text(AppLocalizations.of(context)?.email ?? "Email or Mobile number")
Text(AppLocalizations.of(context)?.password ?? "Password")
Text(AppLocalizations.of(context)?.forgot_password ?? "Forgot Password?")
Text(AppLocalizations.of(context)?.sign_in ?? "Sign in")
Text(AppLocalizations.of(context)?.dont_have_account ?? "Don't have an account?")
Text(AppLocalizations.of(context)?.sign_up ?? "Signup")
```

### مثال 2: صفحة الملف الشخصي

```dart
// قبل الترجمة
Text("Personal Information")
Text("Edit Profile")
Text("Change Password")
Text("Language Settings")
Text("Dark Mode")
Text("About")
Text("Logout")

// بعد الترجمة
Text(AppLocalizations.of(context)?.personal_info ?? "Personal Information")
Text(AppLocalizations.of(context)?.edit_profile ?? "Edit Profile")
Text(AppLocalizations.of(context)?.change_password ?? "Change Password")
Text(AppLocalizations.of(context)?.language_settings ?? "Language Settings")
Text(AppLocalizations.of(context)?.dark_mode ?? "Dark Mode")
Text(AppLocalizations.of(context)?.about ?? "About")
Text(AppLocalizations.of(context)?.logout ?? "Logout")
```

### مثال 3: صفحة الحجز

```dart
// قبل الترجمة
Text("Book Service")
Text("Service Details")
Text("Provider Details")
Text("Price")
Text("Duration")
Text("Location")
Text("Date")
Text("Time")
Text("Pay Now")

// بعد الترجمة
Text(AppLocalizations.of(context)?.book_service ?? "Book Service")
Text(AppLocalizations.of(context)?.service_details ?? "Service Details")
Text(AppLocalizations.of(context)?.provider_details ?? "Provider Details")
Text(AppLocalizations.of(context)?.price ?? "Price")
Text(AppLocalizations.of(context)?.duration ?? "Duration")
Text(AppLocalizations.of(context)?.location ?? "Location")
Text(AppLocalizations.of(context)?.date ?? "Date")
Text(AppLocalizations.of(context)?.time ?? "Time")
Text(AppLocalizations.of(context)?.pay_now ?? "Pay Now")
```

## قائمة الصفحات المطلوب ترجمتها

### صفحات المصادقة (Auth)
- [x] `signin_screen.dart` - صفحة تسجيل الدخول
- [ ] `signup_screen.dart` - صفحة إنشاء حساب
- [ ] `forgot_password_screen.dart` - صفحة نسيان كلمة المرور
- [ ] `reset_password_screen.dart` - صفحة إعادة تعيين كلمة المرور
- [ ] `verification_code_screen.dart` - صفحة رمز التحقق

### الصفحات الرئيسية
- [x] `home_screen.dart` - الشاشة الرئيسية
- [x] `main_screen.dart` - الشاشة الرئيسية مع التنقل
- [ ] `search_screen.dart` - صفحة البحث
- [ ] `category_details_screen.dart` - تفاصيل الفئة
- [ ] `service_details_screen.dart` - تفاصيل الخدمة
- [ ] `provider_details_screen.dart` - تفاصيل المزود

### صفحات الحجز والدفع
- [ ] `book_service_screen.dart` - حجز الخدمة
- [ ] `schedule_screen.dart` - جدولة الموعد
- [ ] `confirm_payment_screen.dart` - تأكيد الدفع
- [ ] `cancel_booking_screen.dart` - إلغاء الحجز

### صفحات المستخدم
- [ ] `profile_screen.dart` - الملف الشخصي
- [ ] `account_screen.dart` - إعدادات الحساب
- [ ] `settings_screen.dart` - الإعدادات
- [ ] `my_services_screen.dart` - خدماتي

### صفحات التواصل
- [ ] `notifications_screen.dart` - الإشعارات
- [ ] `chat_screen.dart` - المحادثة
- [ ] `chats_list_screen.dart` - قائمة المحادثات
- [ ] `support_screen.dart` - الدعم

### صفحات إضافية
- [ ] `favorites_screen.dart` - المفضلة
- [ ] `provider_reviews_screen.dart` - تقييمات المزود
- [ ] `provider_feedback_screen.dart` - تعليقات المزود

## كيفية إضافة نص جديد

### 1. إضافة النص إلى ملفات ARB

#### في `lib/l10n/app_en.arb`
```json
{
    "new_text_key": "New Text in English"
}
```

#### في `lib/l10n/app_ar.arb`
```json
{
    "new_text_key": "النص الجديد بالعربية"
}
```

#### في `lib/l10n/app_ku.arb`
```json
{
    "new_text_key": "دەقی نوێ بە کوردی"
}
```

### 2. توليد ملفات الترجمة
```bash
flutter gen-l10n
```

### 3. استخدام النص الجديد
```dart
Text(AppLocalizations.of(context)?.new_text_key ?? 'Fallback Text')
```

## نصائح مهمة

### 1. استخدام Fallback
دائماً استخدم fallback text في حالة عدم توفر الترجمة:
```dart
// صحيح
Text(AppLocalizations.of(context)?.welcome ?? 'Welcome')

// خطأ
Text(AppLocalizations.of(context)!.welcome) // قد يسبب خطأ إذا لم تتوفر الترجمة
```

### 2. تجميع النصوص المتشابهة
إذا كان لديك نصوص متشابهة، استخدم نفس المفتاح:
```dart
// استخدم نفس المفتاح
Text(AppLocalizations.of(context)?.save ?? 'Save')
Text(AppLocalizations.of(context)?.save ?? 'Save')
```

### 3. استخدام النصوص الديناميكية
للنصوص التي تحتوي على متغيرات:
```dart
// في ملف ARB
{
    "welcome_user": "Welcome, {name}",
    "@welcome_user": {
        "placeholders": {
            "name": {
                "type": "String"
            }
        }
    }
}

// في الكود
Text(AppLocalizations.of(context)?.welcome_user('John') ?? 'Welcome, John')
```

### 4. ترجمة رسائل الخطأ
```dart
// رسائل التحقق
validator: (val) => val == null || val.isEmpty
    ? AppLocalizations.of(context)?.email ?? 'Please enter email'
    : null,

// رسائل النجاح
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(AppLocalizations.of(context)?.payment_successful ?? 'Payment Successful')),
);
```

## خطوات العمل

### للصفحة الجديدة:

1. **أضف import** في بداية الملف
2. **حدد النصوص الثابتة** في الصفحة
3. **أضف النصوص إلى ملفات ARB** إذا لم تكن موجودة
4. **شغل `flutter gen-l10n`** لتوليد الملفات
5. **استبدل النصوص** بـ `AppLocalizations.of(context)?.key ?? 'fallback'`
6. **اختبر الترجمة** بتغيير اللغة

### للصفحة الموجودة:

1. **ابحث عن النصوص الثابتة** باستخدام Ctrl+F
2. **تحقق من وجود الترجمة** في ملفات ARB
3. **أضف النصوص المفقودة** إذا لزم الأمر
4. **استبدل النصوص** خطوة بخطوة
5. **اختبر كل تغيير** للتأكد من عدم وجود أخطاء

## استكشاف الأخطاء

### مشكلة: النص لا يظهر مترجماً
1. تأكد من تشغيل `flutter gen-l10n`
2. تأكد من إضافة النص في جميع ملفات ARB
3. تأكد من استخدام المفتاح الصحيح

### مشكلة: خطأ في الترجمة
1. تأكد من صحة صيغة JSON في ملفات ARB
2. تأكد من وجود جميع المفاتيح في جميع اللغات
3. تأكد من عدم وجود فواصل زائدة في JSON

### مشكلة: التطبيق لا يبدأ
1. تأكد من صحة صيغة ملفات ARB
2. تأكد من تشغيل `flutter clean` ثم `flutter pub get`
3. تأكد من عدم وجود أخطاء في الكود

## النصوص المتاحة حالياً

### النصوص الأساسية
- `welcome`, `home`, `categories`, `services`, `favorites`, `profile`
- `settings`, `notifications`, `chat`, `support`, `logout`
- `search`, `book_now`, `cancel`, `confirm`, `save`, `edit`, `delete`

### نصوص المصادقة
- `sign_in`, `sign_up`, `email`, `password`, `confirm_password`
- `forgot_password`, `reset_password`, `verification_code`
- `dont_have_account`, `already_have_account`, `create_account`

### نصوص الحجز والدفع
- `book_service`, `service_details`, `provider_details`
- `price`, `duration`, `location`, `date`, `time`, `schedule`
- `payment`, `payment_method`, `total_amount`, `pay_now`
- `payment_successful`, `payment_failed`, `booking_confirmed`

### نصوص التواصل
- `message`, `messages`, `new_message`, `type_message`
- `send_message`, `online`, `offline`, `last_seen`, `typing`

### نصوص الحالة
- `loading`, `error_occurred`, `no_data`, `no_results_found`
- `are_you_sure`, `this_action_cannot_be_undone`

## خاتمة

باتباع هذا الدليل، ستتمكن من إضافة الترجمة لجميع صفحات التطبيق بسهولة. تذكر دائماً:

1. **استخدم fallback text** لتجنب الأخطاء
2. **اختبر الترجمة** بعد كل تغيير
3. **حافظ على تناسق** في استخدام مفاتيح الترجمة
4. **وثق النصوص الجديدة** في هذا الدليل

للحصول على مساعدة إضافية، راجع ملف `I18N_GUIDE.md` للحصول على معلومات أكثر تفصيلاً حول نظام الترجمة. 