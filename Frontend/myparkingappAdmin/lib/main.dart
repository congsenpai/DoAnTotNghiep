
// ignore_for_file: depend_on_referenced_packages, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'app/localization/app_localizations.dart';
import 'app/theme/app_theme.dart';
import 'bloc/Auth/AuthBloc.dart';
import 'bloc/MainApp/MainAppBloc.dart';
import 'bloc/Register/RegistedBloc.dart';
import 'controllers/menu_app_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/user.dart';


void main() {
  runApp(
    MultiProvider(
        providers: [
          MultiProvider( providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
            BlocProvider(create: (context)=>AuthBloc()),
            BlocProvider(create: (context)=>RegisterBloc()),
            BlocProvider(create: (context)=>MainAppBloc()),
          ]
          )
        ],
        child:MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Ngôn ngữ mặc định là tiếng Anh
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  // This widget is the root of your application.
  User u = User(
    userId: '1',
    username: 'john_doe',
    password: 'password123',
    phoneNumber: '123-456-7890',
    homeAddress: '123 Main St',
    companyAddress: '456 Business Blvd',
    lastName: 'Doe',
    firstName: 'John',
    avatar: 'assets/images/profile_pic.png',
    email: 'john.doe@example.com',
    status: true, roles: [],
  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: AppTheme.lightTheme, // Áp dụng Light Theme
        darkTheme: AppTheme.darkTheme, // Áp dụng Dark Theme
        themeMode: ThemeMode.system,
        locale: _locale, // Áp dụng ngôn ngữ hiện tại
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('vi', ''), // Vietnamese
        ],
        home:
        MainScreen(isAuth: true, user: u, onLanguageChange: (Locale newLocale) {
          Get.updateLocale(newLocale);
        }, token: 'eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzbWFydHBhcmtpbmdhcHAiLCJzdWIiOiJhZG1pbjEiLCJleHAiOjE3NDAwMzY4MDgsImlhdCI6MTc0MDAzMDgwOCwic2NvcGUiOiJBRE1JTiJ9.Kx8yihyNT4SSZyNNZsgSflvDhLiqHazyIt9LD3ZOReY',)
        // LoginScreen(isAuth: false, onLanguageChange: (Locale newLocale) {
        //   Get.updateLocale(newLocale);
        // },)
    );
  }
}
