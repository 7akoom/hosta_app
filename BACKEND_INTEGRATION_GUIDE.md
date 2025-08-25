# دليل ربط التطبيق بالباك إند

## الوضع الحالي

حالياً، التطبيق يعرض مستخدم وهمي في صفحة البروفايل لعرض واجهة معلومات الحساب. هذا يسمح للمطورين برؤية كيف ستظهر واجهة المستخدم عند ربط التطبيق بالباك إند.

## المستخدم الوهمي

### معلومات المستخدم الوهمي:
- **الاسم**: أحمد محمد
- **البريد الإلكتروني**: ahmed.mohamed@example.com
- **رقم الهاتف**: +964 750 123 4567
- **المدينة**: بغداد
- **العنوان**: شارع الرشيد، بغداد، العراق

### كيفية إخفاء المستخدم الوهمي:
1. انتقل إلى صفحة البروفايل
2. اضغط على "إخفاء المستخدم الوهمي" في أسفل الصفحة
3. سيتم إخفاء المستخدم الوهمي وعرض حالة عدم تسجيل الدخول

## خطوات ربط الباك إند

### 1. إعداد API Endpoints

تأكد من أن الباك إند يوفر النقاط التالية:

```dart
// نقاط API المطلوبة
POST /api/auth/login          // تسجيل الدخول
POST /api/auth/register       // تسجيل حساب جديد
POST /api/auth/logout         // تسجيل الخروج
GET  /api/user/profile        // جلب معلومات المستخدم
PUT  /api/user/profile        // تحديث معلومات المستخدم
POST /api/auth/refresh        // تجديد التوكن
```

### 2. تعديل AuthProvider

عند ربط الباك إند، قم بتعديل `AuthProvider` كالتالي:

```dart
class AuthProvider extends ChangeNotifier {
  // إزالة دالة _createMockUser()
  // إزالة دالة toggleMockUser()
  
  Future<void> _initializeAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null) {
      try {
        // جلب معلومات المستخدم من الباك إند
        _user = await _authRepository.getUserProfile();
      } catch (e) {
        // في حالة حدوث خطأ، نقوم بمسح التوكن
        await prefs.remove('access_token');
        _user = null;
      }
    } else {
      _user = null; // لا يوجد مستخدم مسجل
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signOut();
      _user = null; // إزالة المستخدم بدلاً من إعادة المستخدم الوهمي
      _error = null;
    } catch (e) {
      _error = e is NetworkException ? e.message : 'Sign out failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

### 3. تعديل ProfileScreen

عند ربط الباك إند، قم بتعديل `ProfileScreen` كالتالي:

```dart
class ProfileScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (user != null) ...[
                  // عرض معلومات المستخدم الحقيقي
                  _buildProfileHeader(context, user),
                  const SizedBox(height: 24),
                  _buildProfileOptions(context),
                  const SizedBox(height: 24),
                  _buildAccountActions(context, authProvider),
                ] else ...[
                  // عرض رابط تسجيل الدخول للمستخدمين غير المسجلين
                  _buildGuestProfile(context),
                  const SizedBox(height: 24),
                  _buildProfileOptions(context),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuestProfile(BuildContext context) {
    // إعادة إضافة واجهة الزائر
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.1).toInt())
            : AppColors.boxColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.2).toInt())
              : AppColors.boxBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: isDark
                ? AppColors.dark.withAlpha((255 * 0.2).toInt())
                : AppColors.boxColor,
            child: Icon(
              Icons.person_outline,
              size: 40,
              color: isDark ? AppColors.white : AppColors.dark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.guest ?? 'Guest',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    AppLocalizations.of(context)?.sign_in ?? 'Sign in',
                    style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 4. إضافة Middleware للمصادقة

أضف middleware للتحقق من حالة المصادقة في الشاشات التي تتطلب تسجيل الدخول:

```dart
class AuthMiddleware {
  static Route<dynamic>? handleAuth(BuildContext context, RouteSettings settings) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // قائمة الشاشات التي تتطلب تسجيل الدخول
    final protectedRoutes = [
      '/account',
      '/my-services',
      '/favorites',
      '/chats',
    ];
    
    if (protectedRoutes.contains(settings.name) && !authProvider.isAuthenticated) {
      // توجيه المستخدم إلى صفحة تسجيل الدخول
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
        settings: settings,
      );
    }
    
    return null;
  }
}
```

### 5. تحديث App Routes

```dart
class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // التحقق من المصادقة أولاً
    final authRoute = AuthMiddleware.handleAuth(navigatorKey.currentContext!, settings);
    if (authRoute != null) return authRoute;
    
    // باقي التوجيهات
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      // ... باقي المسارات
    }
  }
}
```

## اختبار التكامل

### 1. اختبار تسجيل الدخول
- تأكد من أن تسجيل الدخول يعمل بشكل صحيح
- تحقق من حفظ التوكن في SharedPreferences
- تأكد من جلب معلومات المستخدم بعد تسجيل الدخول

### 2. اختبار تسجيل الخروج
- تأكد من مسح التوكن من SharedPreferences
- تحقق من إعادة توجيه المستخدم إلى صفحة تسجيل الدخول

### 3. اختبار تجديد التوكن
- تأكد من تجديد التوكن تلقائياً عند انتهاء صلاحيته
- تحقق من عدم انقطاع جلسة المستخدم

### 4. اختبار الشاشات المحمية
- تأكد من توجيه المستخدمين غير المسجلين إلى صفحة تسجيل الدخول
- تحقق من إمكانية الوصول للشاشات المحمية بعد تسجيل الدخول

## ملاحظات مهمة

1. **الأمان**: تأكد من استخدام HTTPS لجميع طلبات API
2. **التوكن**: استخدم JWT tokens مع صلاحية محدودة
3. **التخزين**: احفظ التوكن بشكل آمن في SharedPreferences
4. **التحديث**: أضف آلية لتحديث التوكن تلقائياً
5. **معالجة الأخطاء**: أضف معالجة شاملة للأخطاء في جميع طلبات API

## إزالة الكود الوهمي

بعد ربط الباك إند بنجاح، قم بإزالة:

1. دالة `_createMockUser()` من `AuthProvider`
2. دالة `toggleMockUser()` من `AuthProvider`
3. دالة `_buildMockUserToggle()` من `ProfileScreen`
4. جميع المراجع للمستخدم الوهمي في الكود


## الوضع الحالي

حالياً، التطبيق يعرض مستخدم وهمي في صفحة البروفايل لعرض واجهة معلومات الحساب. هذا يسمح للمطورين برؤية كيف ستظهر واجهة المستخدم عند ربط التطبيق بالباك إند.

## المستخدم الوهمي

### معلومات المستخدم الوهمي:
- **الاسم**: أحمد محمد
- **البريد الإلكتروني**: ahmed.mohamed@example.com
- **رقم الهاتف**: +964 750 123 4567
- **المدينة**: بغداد
- **العنوان**: شارع الرشيد، بغداد، العراق

### كيفية إخفاء المستخدم الوهمي:
1. انتقل إلى صفحة البروفايل
2. اضغط على "إخفاء المستخدم الوهمي" في أسفل الصفحة
3. سيتم إخفاء المستخدم الوهمي وعرض حالة عدم تسجيل الدخول

## خطوات ربط الباك إند

### 1. إعداد API Endpoints

تأكد من أن الباك إند يوفر النقاط التالية:

```dart
// نقاط API المطلوبة
POST /api/auth/login          // تسجيل الدخول
POST /api/auth/register       // تسجيل حساب جديد
POST /api/auth/logout         // تسجيل الخروج
GET  /api/user/profile        // جلب معلومات المستخدم
PUT  /api/user/profile        // تحديث معلومات المستخدم
POST /api/auth/refresh        // تجديد التوكن
```

### 2. تعديل AuthProvider

عند ربط الباك إند، قم بتعديل `AuthProvider` كالتالي:

```dart
class AuthProvider extends ChangeNotifier {
  // إزالة دالة _createMockUser()
  // إزالة دالة toggleMockUser()
  
  Future<void> _initializeAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null) {
      try {
        // جلب معلومات المستخدم من الباك إند
        _user = await _authRepository.getUserProfile();
      } catch (e) {
        // في حالة حدوث خطأ، نقوم بمسح التوكن
        await prefs.remove('access_token');
        _user = null;
      }
    } else {
      _user = null; // لا يوجد مستخدم مسجل
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signOut();
      _user = null; // إزالة المستخدم بدلاً من إعادة المستخدم الوهمي
      _error = null;
    } catch (e) {
      _error = e is NetworkException ? e.message : 'Sign out failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

### 3. تعديل ProfileScreen

عند ربط الباك إند، قم بتعديل `ProfileScreen` كالتالي:

```dart
class ProfileScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (user != null) ...[
                  // عرض معلومات المستخدم الحقيقي
                  _buildProfileHeader(context, user),
                  const SizedBox(height: 24),
                  _buildProfileOptions(context),
                  const SizedBox(height: 24),
                  _buildAccountActions(context, authProvider),
                ] else ...[
                  // عرض رابط تسجيل الدخول للمستخدمين غير المسجلين
                  _buildGuestProfile(context),
                  const SizedBox(height: 24),
                  _buildProfileOptions(context),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuestProfile(BuildContext context) {
    // إعادة إضافة واجهة الزائر
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.1).toInt())
            : AppColors.boxColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.2).toInt())
              : AppColors.boxBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: isDark
                ? AppColors.dark.withAlpha((255 * 0.2).toInt())
                : AppColors.boxColor,
            child: Icon(
              Icons.person_outline,
              size: 40,
              color: isDark ? AppColors.white : AppColors.dark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.guest ?? 'Guest',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    AppLocalizations.of(context)?.sign_in ?? 'Sign in',
                    style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 4. إضافة Middleware للمصادقة

أضف middleware للتحقق من حالة المصادقة في الشاشات التي تتطلب تسجيل الدخول:

```dart
class AuthMiddleware {
  static Route<dynamic>? handleAuth(BuildContext context, RouteSettings settings) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // قائمة الشاشات التي تتطلب تسجيل الدخول
    final protectedRoutes = [
      '/account',
      '/my-services',
      '/favorites',
      '/chats',
    ];
    
    if (protectedRoutes.contains(settings.name) && !authProvider.isAuthenticated) {
      // توجيه المستخدم إلى صفحة تسجيل الدخول
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
        settings: settings,
      );
    }
    
    return null;
  }
}
```

### 5. تحديث App Routes

```dart
class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // التحقق من المصادقة أولاً
    final authRoute = AuthMiddleware.handleAuth(navigatorKey.currentContext!, settings);
    if (authRoute != null) return authRoute;
    
    // باقي التوجيهات
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      // ... باقي المسارات
    }
  }
}
```

## اختبار التكامل

### 1. اختبار تسجيل الدخول
- تأكد من أن تسجيل الدخول يعمل بشكل صحيح
- تحقق من حفظ التوكن في SharedPreferences
- تأكد من جلب معلومات المستخدم بعد تسجيل الدخول

### 2. اختبار تسجيل الخروج
- تأكد من مسح التوكن من SharedPreferences
- تحقق من إعادة توجيه المستخدم إلى صفحة تسجيل الدخول

### 3. اختبار تجديد التوكن
- تأكد من تجديد التوكن تلقائياً عند انتهاء صلاحيته
- تحقق من عدم انقطاع جلسة المستخدم

### 4. اختبار الشاشات المحمية
- تأكد من توجيه المستخدمين غير المسجلين إلى صفحة تسجيل الدخول
- تحقق من إمكانية الوصول للشاشات المحمية بعد تسجيل الدخول

## ملاحظات مهمة

1. **الأمان**: تأكد من استخدام HTTPS لجميع طلبات API
2. **التوكن**: استخدم JWT tokens مع صلاحية محدودة
3. **التخزين**: احفظ التوكن بشكل آمن في SharedPreferences
4. **التحديث**: أضف آلية لتحديث التوكن تلقائياً
5. **معالجة الأخطاء**: أضف معالجة شاملة للأخطاء في جميع طلبات API

## إزالة الكود الوهمي

بعد ربط الباك إند بنجاح، قم بإزالة:

1. دالة `_createMockUser()` من `AuthProvider`
2. دالة `toggleMockUser()` من `AuthProvider`
3. دالة `_buildMockUserToggle()` من `ProfileScreen`
4. جميع المراجع للمستخدم الوهمي في الكود


