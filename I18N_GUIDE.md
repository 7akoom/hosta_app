# دليل الترجمة (i18n) في تطبيق Hosta

## نظرة عامة

تم تنفيذ نظام الترجمة في التطبيق باستخدام Flutter's built-in internationalization (i18n) مع دعم للغات التالية:
- الإنجليزية (English)
- العربية (العربية)
- الكردية (کوردی)

## كيفية عمل الترجمة

### 1. إعداد الترجمة

تم إعداد الترجمة في الملفات التالية:
- `l10n.yaml` - ملف إعدادات الترجمة
- `lib/l10n/app_en.arb` - النصوص الإنجليزية
- `lib/l10n/app_ar.arb` - النصوص العربية
- `lib/l10n/app_ku.arb` - النصوص الكردية

### 2. توليد ملفات الترجمة

لتوليد ملفات الترجمة، قم بتشغيل الأمر:
```bash
flutter gen-l10n
```

### 3. استخدام الترجمة في الكود

#### إضافة import
```dart
import 'package:hosta_app/generated/app_localizations.dart';
```

#### استخدام النصوص المترجمة
```dart
// استخدام النص المترجم مع fallback
Text(AppLocalizations.of(context)?.welcome ?? 'Welcome')

// أو استخدام النص مباشرة
Text(AppLocalizations.of(context)!.welcome)
```

### 4. إدارة اللغة

#### حفظ اللغة المختارة
```dart
final settings = context.read<AppSettingsProvider>();
await settings.setLanguage('ar'); // للعربية
await settings.setLanguage('en'); // للإنجليزية
await settings.setLanguage('ku'); // للكردية
```

#### قراءة اللغة الحالية
```dart
final currentLanguage = settings.selectedLanguage;
final currentLocale = settings.locale;
```

## النصوص المترجمة المتاحة

### النصوص الأساسية
- `welcome` - ترحيب
- `app_name` - اسم التطبيق
- `select_language` - اختيار اللغة
- `home` - الرئيسية
- `categories` - الفئات
- `services` - الخدمات
- `favorites` - المفضلة
- `profile` - الملف الشخصي
- `settings` - الإعدادات
- `notifications` - الإشعارات
- `chat` - المحادثة
- `support` - الدعم
- `logout` - تسجيل الخروج

### النصوص التفاعلية
- `search` - بحث
- `search_service` - ابحث عن خدمة
- `book_now` - احجز الآن
- `cancel` - إلغاء
- `confirm` - تأكيد
- `try_again` - حاول مرة أخرى

### رسائل الحالة
- `loading` - جاري التحميل
- `loading_categories` - جاري تحميل الفئات
- `no_data` - لا توجد بيانات
- `no_categories_available` - لا توجد فئات متاحة
- `error_occurred` - حدث خطأ
- `no_internet` - لا يوجد اتصال بالإنترنت
- `please_wait` - يرجى الانتظار

### النصوص في الشاشة الرئيسية
- `services_count` - عدد الخدمات
- `my_services` - خدماتي
- `press_back_again` - اضغط مرة أخرى للخروج

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

## إعدادات التطبيق

### في `main.dart`
```dart
MaterialApp(
  locale: appSettings.locale,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en'), // English
    Locale('ar'), // Arabic
    Locale('ku'), // Kurdish
  ],
  // ...
)
```

### في `AppSettingsProvider`
```dart
class AppSettingsProvider extends ChangeNotifier {
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'ar': 'العربية',
    'ku': 'کوردی',
  };
  
  Locale get locale => Locale(_selectedLanguage);
  
  Future<void> setLanguage(String language) async {
    if (language != _selectedLanguage && supportedLanguages.containsKey(language)) {
      _selectedLanguage = language;
      await _prefs.setString('selected_language', language);
      notifyListeners();
    }
  }
}
```

## حفظ واسترجاع اللغة

### حفظ اللغة
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('selected_language', 'ar');
```

### استرجاع اللغة
```dart
final prefs = await SharedPreferences.getInstance();
final language = prefs.getString('selected_language') ?? 'en';
```

## ملاحظات مهمة

1. **توليد الملفات**: تأكد من تشغيل `flutter gen-l10n` بعد إضافة أي نص جديد
2. **Fallback**: استخدم دائماً fallback text في حالة عدم توفر الترجمة
3. **Context**: تأكد من أن context متاح عند استخدام `AppLocalizations.of(context)`
4. **Hot Reload**: قد تحتاج لإعادة تشغيل التطبيق بعد تغيير ملفات الترجمة

## استكشاف الأخطاء

### مشكلة: النص لا يظهر مترجماً
1. تأكد من تشغيل `flutter gen-l10n`
2. تأكد من إضافة النص في جميع ملفات ARB
3. تأكد من استخدام المفتاح الصحيح

### مشكلة: اللغة لا تتغير
1. تأكد من حفظ اللغة في SharedPreferences
2. تأكد من استدعاء `notifyListeners()` في AppSettingsProvider
3. تأكد من أن locale يتم تحديثه في MaterialApp

### مشكلة: التطبيق لا يبدأ
1. تأكد من صحة صيغة ملفات ARB (JSON صحيح)
2. تأكد من وجود جميع المفاتيح في جميع اللغات
3. تأكد من تشغيل `flutter clean` ثم `flutter pub get` 