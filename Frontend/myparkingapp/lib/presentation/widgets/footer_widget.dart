// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/data/model/user.dart';

import '../screens/HomeScreens/home_screen.dart';
import '../screens/SettingScreens/SettingScreen.dart';


class footerWidget extends StatelessWidget {
  final User user; // Thêm biến này để lưu trữ thông tin user
  final String token;
  final Function(Locale) onLanguageChange;

  const footerWidget({
    super.key, required this.user, required this.token, required this.onLanguageChange,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 6, // Điều chỉnh chiều cao của bottom navigation
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 12,right: Get.width / 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/icons/icon_vip/12.png', // Đường dẫn đến ảnh của bạn
                width: Get.width / 20, // Kích thước icon
                height: Get.width / 20,
              ),
              onPressed: () async {
                // final userModel =
                //     await Provider.of<UserProvider>(context, listen: false)
                //         .loadUser();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user, token: '', onLanguageChange: onLanguageChange,)));
              },
            ),
            SizedBox(
              width: Get.width / 20,
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/icon_vip/23.png', // Đường dẫn đến ảnh của bạn
                width: Get.width / 20, // Kích thước icon
                height: Get.width / 20,
              ),
              onPressed: () async {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             MyOrdersScreen(userID: userID, userName: userName)));
              },
            ),
            SizedBox(
              width: Get.width / 20,
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/icon_vip/24.png', // Đường dẫn đến ảnh của bạn
                width: Get.width / 20, // Kích thước icon
                height: Get.width / 20,
              ),
              onPressed: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => WalletScreen(
                //               userID: userID,
                //               userName2: userName,
                //             )));
              },
            ),
            SizedBox(
              width: Get.width / 20,
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/icon_vip/31.png', // Đường dẫn đến ảnh của bạn
                width: Get.width / 20, // Kích thước icon
                height:Get.width / 20,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingsScreen(user: user, token: '', onLanguageChange: onLanguageChange,)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
