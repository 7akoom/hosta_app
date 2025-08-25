# ميزة اللغات - Languages Feature

## نظرة عامة
تم إضافة ميزة اللغات التي يتكلمها مزود الخدمة لتسهيل التواصل بين المستخدمين ومزودي الخدمات.

## اللغات المدعومة
- **الكردية (Kurdish):** کوردی
- **العربية (Arabic):** العربية  
- **الإنجليزية (English):** English

## التحديثات المطبقة

### 1. تحديث ProviderModel
تم إضافة حقل `languages` إلى نموذج مزود الخدمة:

```dart
class ProviderModel {
  // ... الحقول الأخرى
  final List<String>? languages;
  
  const ProviderModel({
    // ... المعاملات الأخرى
    this.languages,
  });
}
```

### 2. إنشاء LanguageBadges Widget
تم إنشاء widget مخصص لعرض اللغات:

```dart
class LanguageBadges extends StatelessWidget {
  final List<String>? languages;
  final bool isDark;
  final double fontSize;
  final double padding;
  final double borderRadius;
  
  // ... باقي الكود
}
```

### 3. ميزات LanguageBadges

#### الألوان المخصصة:
- **الكردية:** أخضر (#4CAF50)
- **العربية:** أزرق (#2196F3)
- **الإنجليزية:** برتقالي (#FF9800)

#### التصميم:
- Badges دائرية مع حدود ملونة
- خلفية شفافة بلون اللغة
- نص بلون اللغة
- قابل للتخصيص (حجم الخط، التباعد، نصف القطر)

### 4. تحديث البيانات الوهمية
تم إضافة اللغات لجميع مزودي الخدمات في `static_provider_data.dart`:

```dart
languages: i % 3 == 0 
    ? ['English', 'Arabic', 'Kurdish']  // ثلاث لغات
    : i % 2 == 0 
        ? ['English', 'Arabic']         // لغتان
        : ['English', 'Kurdish'],       // لغتان
```

### 5. تحديث واجهة تفاصيل المزود
تم إضافة قسم اللغات في `provider_details_screen.dart`:

```dart
// Languages Section
if (_provider!.languages != null && _provider!.languages!.isNotEmpty) ...[
  Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.language, size: 16, color: AppColors.primaryBlue),
      const SizedBox(width: 4),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Languages'),
            const SizedBox(height: 8),
            LanguageBadges(
              languages: _provider!.languages,
              isDark: isDark,
              fontSize: 12,
              padding: 6,
              borderRadius: 10,
            ),
          ],
        ),
      ),
    ],
  ),
],
```

### 6. تحديث واجهة قائمة المزودين
تم إضافة عرض اللغات في `service_details_screen.dart`:

```dart
// Languages in Provider Card
if (provider.languages != null && provider.languages!.isNotEmpty) ...[
  LanguageBadges(
    languages: provider.languages,
    isDark: isDark,
    fontSize: 10,
    padding: 3,
    borderRadius: 6,
  ),
],
```

## كيفية الاستخدام

### 1. في واجهة تفاصيل المزود:
- تظهر اللغات تحت عنوان "Languages"
- كل لغة لها badge ملون خاص بها
- يتم عرض اللغات فقط إذا كانت متوفرة

### 2. في واجهة قائمة المزودين:
- تظهر اللغات في بطاقة كل مزود
- أحجام أصغر للتناسب مع البطاقة
- عرض سريع للغات المتاحة

### 3. في أي مكان آخر:
يمكن استخدام `LanguageBadges` في أي مكان لعرض لغات المزود:

```dart
LanguageBadges(
  languages: provider.languages,
  isDark: isDark,
  fontSize: 10,
  padding: 4,
  borderRadius: 8,
)
```

## المميزات

### 1. مرونة في التصميم:
- أحجام قابلة للتخصيص
- ألوان مخصصة لكل لغة
- دعم الثيم الفاتح والداكن

### 2. سهولة الاستخدام:
- عرض تلقائي للغات المتوفرة
- إخفاء تلقائي إذا لم تكن هناك لغات
- تصميم متجاوب

### 3. قابلية التوسع:
- سهولة إضافة لغات جديدة
- دعم رموز اللغات المختلفة
- قابلية التخصيص الكاملة

## التوزيع في البيانات الوهمية

### نمط التوزيع:
- **ثلاث لغات:** كل مزود ثالث (i % 3 == 0)
- **لغتان (إنجليزي + عربي):** كل مزود ثاني (i % 2 == 0)
- **لغتان (إنجليزي + كردي):** باقي المزودين

### أمثلة:
- CleanPro Services: English, Arabic, Kurdish
- Sparkle Clean: English, Arabic
- Cleaning Provider 3: English, Kurdish
- Cleaning Provider 4: English, Arabic, Kurdish

## الواجهات المحدثة

### 1. واجهة تفاصيل المزود (`provider_details_screen.dart`):
- ✅ إضافة قسم اللغات مع أيقونة
- ✅ عرض اللغات بشكل كبير وواضح
- ✅ إخفاء تلقائي إذا لم تكن متوفرة

### 2. واجهة قائمة المزودين (`service_details_screen.dart`):
- ✅ إضافة اللغات في بطاقة كل مزود
- ✅ أحجام صغيرة مناسبة للبطاقة
- ✅ استخدام البيانات الوهمية من `StaticProviderData`
- ✅ عرض سريع للغات المتاحة

## التوصيات المستقبلية

### 1. إضافة لغات جديدة:
- التركية
- الفارسية
- الألمانية

### 2. تحسينات التصميم:
- أيقونات للغات
- تأثيرات بصرية
- رسوم متحركة

### 3. ميزات إضافية:
- فلترة المزودين حسب اللغة
- ترتيب حسب عدد اللغات
- مؤشر مستوى اللغة

## اختبار الوظائف

تأكد من:
- [ ] ظهور اللغات في واجهة تفاصيل المزود
- [ ] ظهور اللغات في واجهة قائمة المزودين
- [ ] ألوان صحيحة لكل لغة
- [ ] عدم ظهور قسم اللغات إذا لم تكن متوفرة
- [ ] تصميم متجاوب مع أحجام الشاشات المختلفة
- [ ] دعم الثيم الفاتح والداكن
- [ ] أحجام مناسبة لكل واجهة
