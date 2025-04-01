// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field, avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../app/localization/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../constants.dart';
import '../../dto/response/user.dart';
import '../general/header.dart';
import '../../responsive.dart';
import '../main/components/side_menu.dart';
import '../main/main_screen.dart';
import 'register_screen.dart';
class LoginScreen extends StatefulWidget {
  final bool isAuth;
  final Function(Locale) onLanguageChange;
  const LoginScreen({super.key,
    required this.isAuth, required this.onLanguageChange,
});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  int _currentTab = 0;
  final GlobalKey<ScaffoldState> _LoginscaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late User user = User(
      username: "",
      password: "",
      phoneNumber: "",
      homeAddress: "",
      companyAddress: "",
      lastName: "",
      firstName: "",
      avatar: "", email: '', userId: '',
      status: true, roles: [],
  );
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _LoginscaffoldKey,
      drawer: SideMenu(onMenuTap: (int index) {
        setState(() {
          _currentTab = index;
        });
      }, isAuth: widget.isAuth,),
      body: BlocConsumer<AuthBloc,AuthState>(
        builder: (context,state){
          return
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Expanded(
                      flex: 2,
                      // default flex = 1
                      // and it takes 1/6 part of the screen
                      child: SideMenu(onMenuTap: (int index) {
                        setState(() {
                          _currentTab = index;
                        });
                      }, isAuth: widget.isAuth,
                      ),
                    ),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 6,
                    child: SingleChildScrollView(
                      primary: false,
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Header(title: AppLocalizations.of(context).translate("Login"),user: user, isAuth: widget.isAuth,onLanguageChange: widget.onLanguageChange),
                          SizedBox(height: defaultPadding),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child:
                                Container(
                                  height: Get.height/1.1,
                                  padding: EdgeInsets.all(defaultPadding),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            if (!Responsive.isMobile(context))
                                              Expanded(
                                                flex: 3,

                                                child:
                                                Center(
                                                  child: Image.asset("assets/images/image_Login.png",
                                                    height: Get.height/2,
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                  height: Responsive.isDesktop(context) == true ? Get.height/1.2:Get.height/1.1,
                                                  width: Responsive.isDesktop(context) == true ? Get.width/3 :Get.width/2,
                                                  padding: EdgeInsets.all(defaultPadding),
                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      color: Theme.of(context).colorScheme.primary
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Center(
                                                        child: CircleAvatar(
                                                          radius: Get.width / 20, // Đặt kích thước avatar
                                                          backgroundColor: Colors.grey, // Màu nền
                                                          child: Icon(
                                                            Icons.person, // Icon hiển thị bên trong
                                                            size: Get.width / 15, // Kích thước icon
                                                            color: Colors.white, // Màu icon
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: Get.width/30,),
                                                      Column(
                                                        children: [
                                                          TextField(
                                                            controller: _usernameController,
                                                            decoration: InputDecoration(
                                                              labelText: AppLocalizations.of(context).translate("Email"),
                                                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                                              border: OutlineInputBorder(),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary), // Viền khi focus
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: defaultPadding),
                                                          TextField(
                                                            controller: _passwordController,
                                                            obscureText: true,
                                                            decoration: InputDecoration(
                                                              labelText: AppLocalizations.of(context).translate("Password"),
                                                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                                              border: OutlineInputBorder(),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary), // Viền khi focus
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: defaultPadding),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              TextButton(
                                                                style: TextButton.styleFrom(
                                                                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                                                  disabledForegroundColor: Theme.of(context).colorScheme.onPrimary, // Màu khi bị vô hiệu hóa
                                                                ),
                                                                onPressed: () {
                                                                  print("Chuyển sang trang đăng ký");
                                                                },
                                                                child: Text(AppLocalizations.of(context).translate("Forget Password")),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  TextButton(
                                                                    style: TextButton.styleFrom(
                                                                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                                                      disabledForegroundColor: Theme.of(context).colorScheme.onPrimary, // Màu khi bị vô hiệu hóa
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => RegisterScreen(isAuth: widget.isAuth, onLanguageChange: (Locale ) { widget.onLanguageChange; },),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Text(AppLocalizations.of(context).translate("Register")),
                                                                  ),
                                                                  SizedBox(width: defaultPadding),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      foregroundColor: Theme.of(context).colorScheme.secondary,
                                                                      backgroundColor: Theme.of(context).colorScheme.onPrimary, // Màu chữ trên nền chính
                                                                    ),
                                                                    onPressed: () {
                                                                      print(_usernameController.text);
                                                                      print(_passwordController.text);
                                                                      context.read<AuthBloc>().add(AuthenticateEvent(_usernameController.text, _passwordController.text));
                                                                    },
                                                                    child: Text(AppLocalizations.of(context).translate("Login")),
                                                                  ),
                                                                ],
                                                              ),

                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ),

                                          ]
                                      )
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          );
        },       listener: (context, state) {
        if(state is AuthSuccess){
            String token = state.token;
            user = state.user;
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainScreen(isAuth: true, user: user, onLanguageChange: widget.onLanguageChange, token: token,)),
            );
          }
        else if (state is AuthError) {
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
                      Navigator.of(context).pop();// Đóng hộp thoại
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

