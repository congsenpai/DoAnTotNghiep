// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field, avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../app/localization/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../constants.dart';
import '../general/header.dart';
import '../../responsive.dart';
import '../main/components/side_menu.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isAuth;
  final Function(Locale) onLanguageChange;
  const LoginScreen({
    super.key,
    required this.isAuth,
    required this.onLanguageChange,
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Header(
                            title:
                                AppLocalizations.of(context).translate("Login"),
                            onLanguageChange: widget.onLanguageChange),
                        SizedBox(height: defaultPadding),
                        Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate("Email"),
                                labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary), // Viền khi focus
                                ),
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate("Password"),
                                labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary), // Viền khi focus
                                ),
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    disabledForegroundColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimary, // Màu khi bị vô hiệu hóa
                                  ),
                                  onPressed: () {
                                    
                                  },
                                  child: Text(AppLocalizations.of(context)
                                      .translate("Forget Password")),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimary, // Màu chữ trên nền chính
                                  ),
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                        AuthenticateEvent(
                                            _usernameController.text,
                                            _passwordController.text));
                                  },
                                  child: Text(AppLocalizations.of(context)
                                      .translate("Login")),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    // It takes 5/6 part of the screen
                    flex: 1,
                    child: SizedBox(
                      height: Get.height,
                      child: Image.asset("assets/images/login_banner.jpg"),
                    )),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        isAuth: true,
                        onLanguageChange: widget.onLanguageChange,
                        userName: state.userName,
                      )),
            );
          } else if (state is AuthError) {
            // Hiển thị AlertDialog khi có lỗi
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text(state.message), // Hiển thị thông báo lỗi
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng hộp thoại
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng hộp thoại và thoát
                        // Có thể thêm logic thoát ứng dụng ở đây nếu cần
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
