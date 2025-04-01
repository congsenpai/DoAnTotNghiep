// ignore_for_file: avoid_print, unused_field, non_constant_identifier_names, avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../app/localization/app_localizations.dart';
import '../../bloc/register/RegistedBloc.dart';
import '../../bloc/register/RegistedEvent.dart';
import '../../bloc/register/RegistedState.dart';
import '../../constants.dart';
import '../../dto/response/user.dart';
import '../general/header.dart';
import '../../responsive.dart';
import '../main/components/side_menu.dart';
import 'components/textfile.dart';
import 'login_screen.dart';
class RegisterScreen extends StatefulWidget {
  final bool isAuth;
  final Function(Locale) onLanguageChange;
  const RegisterScreen({super.key,
    required this.isAuth, required this.onLanguageChange,
  });
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  int _currentTab = 1;
  final GlobalKey<ScaffoldState> _registerscaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _companyAddressController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  bool result = false;


  @override
  void initState() {
    super.initState();


  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _registerscaffoldKey,
      drawer: SideMenu(onMenuTap: (int index) {
        setState(() {
          _currentTab = index;
        });
      }, isAuth: widget.isAuth,),
      body: BlocConsumer<RegisterBloc,RegisterState>(
        builder: (context,state){
          return SafeArea(
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
                  }, isAuth: widget.isAuth,),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SingleChildScrollView(
                  primary: false,
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(title: AppLocalizations.of(context).translate("Register"),user: user, isAuth: widget.isAuth,onLanguageChange: widget.onLanguageChange),
                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child:
                            Container(
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: defaultPadding,),
                                  Row(
                                    children: [
                                      Expanded( // Bọc từng Column bằng Expanded để tránh lỗi
                                        child: Column(
                                          children: [
                                            TestFiles(editController: _usernameController, title: 'UserName',),
                                            // user name
                                            SizedBox(height: defaultPadding),
                                            TestFiles(editController: _passwordController, title: 'Password',),
                                            // password
                                            SizedBox(height: defaultPadding),
                                            TestFiles(editController: _repassController, title: 'RePassword',),
                                            // email
                                            SizedBox(height: defaultPadding),
                                            TestFiles(editController: _emailController, title: 'Email',),
                                            SizedBox(height: defaultPadding),
                                            // dia chi cong ty
                                            TestFiles(editController: _numberPhoneController, title: 'Phone',),
                                            SizedBox(height: defaultPadding),

                                            TestFiles(editController: _firstnameController, title: 'firstname',),
                                            SizedBox(height: defaultPadding),

                                            TestFiles(editController: _lastnameController, title: 'lastname',),
                                            SizedBox(height: defaultPadding),

                                            TestFiles(editController: _homeAddressController, title: 'homeaddress',),
                                            SizedBox(height: defaultPadding),

                                            TestFiles(editController: _companyAddressController, title: 'companyaddress',),
                                            SizedBox(height: defaultPadding),



                                          ],
                                        ),
                                      ),
                                      SizedBox(width: Get.width/30,),
                                      ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(AppLocalizations.of(context).translate("Account?")),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                          disabledForegroundColor: Theme.of(context).colorScheme.onPrimary, // Màu khi bị vô hiệu hóa
                                        ),
                                        onPressed: () {
                                          Get.to(LoginScreen(isAuth: false, onLanguageChange: widget.onLanguageChange ),);
                                        },
                                        child: Text(AppLocalizations.of(context).translate("Login")),
                                      ),
                                      SizedBox(width: defaultPadding),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Theme.of(context).colorScheme.secondary,
                                          backgroundColor: Theme.of(context).colorScheme.onPrimary, // Màu chữ trên nền chính
                                        ),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          context.read<RegisterBloc>().add(
                                              RegisteredEvent(
                                                  _usernameController.text,
                                                  _passwordController.text,
                                                  _repassController.text,
                                                  _firstnameController.text,
                                                  _lastnameController.text,
                                                  _emailController.text,
                                                  _homeAddressController.text,
                                                  _companyAddressController.text,
                                                  _numberPhoneController.text)
                                          );
                                        },
                                        child: Text(AppLocalizations.of(context).translate("Register")),
                                      ),
                                    ],
                                  ),
                                ],
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
          
        if(state is RegisterSuccess){
                    result = state.isRegis;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(isAuth: false, onLanguageChange: widget.onLanguageChange ),
                      ),
                    );
                  }
        else if (state is RegisterError) {
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






