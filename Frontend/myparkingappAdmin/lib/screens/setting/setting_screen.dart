
// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/main/components/classInitial.dart';
import '../../constants.dart';
import '../../responsive.dart';
import '../general/header.dart';
import '../dashboard/components/assets_details.dart';


class SettingScreen extends StatelessWidget {
  final bool isAuth;
  final UserResponse user;
  SettingScreen({super.key,
    required this.isAuth,
    required this.user,
  });
  final UserResponse selecteduser = selectedUserInitial;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: "Setting",user: user, isAuth: isAuth, onLanguageChange: (Locale ) {  },),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) AssetsDetails(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
