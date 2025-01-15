import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingapp/presentation/screens/SettingScreens/SettingScreen.dart';

import 'app/locallization/app_localizations.dart';
import 'app/theme/app_theme.dart';
import 'trash/Trash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Ngôn ngữ mặc định là tiếng Anh

  // Hàm thay đổi ngôn ngữ
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme, // Áp dụng Light Theme
      darkTheme: AppTheme.darkTheme, // Áp dụng Dark Theme
      themeMode: ThemeMode.system,
      locale: _locale, // Áp dụng ngôn ngữ hiện tại
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('vi', ''), // Vietnamese
      ],
      home:SettingsScreen(
      userID: '12345',
      userName: 'John Doe',
      onLanguageChange: (Locale newLocale) {
        // Thay đổi ngôn ngữ trong toàn ứng dụng
        Get.updateLocale(newLocale);
      },
    ), // Truyền hàm đổi ngôn ngữ
    );
  }
}
