import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/core/services/api_service.dart';
import 'app/core/storage/storage_service.dart';
import 'app/modules/doctor_profile/controllers/doctor_profile_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة التواريخ للغات
  await initializeDateFormatting('ar');
  await initializeDateFormatting('en');

  await GetStorage.init();
  Get.put(StorageService());
  DioHelper.init();

  final StorageService storage = Get.find<StorageService>();
  final isDarkMode = storage.getIsDarkMode() ?? false;

  // 🔹 الخطوة الجديدة: تحديد اللغة الافتراضية عند أول تشغيل
  String? savedLang = storage.getLanguage();
  if (savedLang == null) {
    // يمكنك استخدام لغة النظام أو تثبيت العربية افتراضياً
    String systemLang = Get.deviceLocale?.languageCode ?? 'ar';
    if (systemLang != 'ar' && systemLang != 'en') {
      systemLang = 'ar'; // افتراضياً العربية إن لم تكن مدعومة
    }
    storage.saveLanguage(systemLang);
    savedLang = systemLang;
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  Get.put(DoctorProfileController());

  runApp(
    GetMaterialApp(
      title: "My App",
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation.translations,
      locale: Locale(savedLang),
      fallbackLocale: const Locale('ar'),
      initialRoute: storage.getToken() != null
          ? (storage.getTYpeOfUser() == true
          ? (storage.getIsAdmin()
          ? AppPages.ADMIN
          : AppPages.LAYOUT_DOCTOR)
          : AppPages.LAYOUT)
          : AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}
