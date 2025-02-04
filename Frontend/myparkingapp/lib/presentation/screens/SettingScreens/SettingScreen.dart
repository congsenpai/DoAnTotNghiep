// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/presentation/screens/SettingScreens/UpdateInforScreen.dart';

import '../../../app/locallization/app_localizations.dart';



class SettingsScreen extends StatefulWidget {
  @override
  const SettingsScreen({super.key, required this.userID, required this.userName, required this.onLanguageChange});
  final String userID;
  final String userName;
  final Function(Locale) onLanguageChange;
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('Setting')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Avatar và số điện thoại
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:  [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.userName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Các mục trong Settings
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: Get.width/10),
              padding: EdgeInsets.only(right :Get.width/20, left: Get.width/20),
              child: Column(
                children: [
                  // edit profile
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: buildListTile(Icons.edit,
                        AppLocalizations.of(context).translate("Edit Profile")
                        , onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const UpdateUserProfile(UserID: "02231d85-4a92-4a34-81fa-d78aa3ea771b",bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzbWFydHBhcmtpbmdhcHAiLCJzdWIiOiJhZG1pbjEiLCJleHAiOjE3Mzg2NjAyNDcsImlhdCI6MTczODY1NDI0Nywic2NvcGUiOiJBRE1JTiJ9.3ne7V9p0dauwPb3vO_fj2ZIuq2fpJmWP0PhgwGDApfI",)));
                    }),
                  ),
                  SizedBox(
                    height: Get.width /20,
                  ),
                  // app language
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: buildListTile(
                        Icons.language,
                        AppLocalizations.of(context).translate("App Language")
                        ,
                        onTap: () {
                      _showLanguageDialog();
                    }),
                  ),
                  SizedBox(
                    height: Get.width /20,
                  ),
                  // My Wallet
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: buildListTile(Icons.wallet,
                        AppLocalizations.of(context).translate("My wallet"),
                        onTap: () {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context)=> WalletScreen(userID: widget.userID, userName2: widget.userName,)));
                    }),
                  ),
                  SizedBox(
                    height: Get.width /20,
                  ),
                  // Notifications
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: buildListTile(Icons.notifications,
                        AppLocalizations.of(context).translate("Notifications")
                        ,
                        onTap: () {}),
                  ),
                  SizedBox(
                    height: Get.width /20,
                  ),
                  // contact and help
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: buildListTile(Icons.help, AppLocalizations.of(context).translate("Contact & Help"), onTap: () {}),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // Bottom Navigation Bar
      // bottomNavigationBar: footerWidget(userID: widget.userID, userName: widget.userName,),
    );
  }

  // Widget cho mỗi mục ListTile
  ListTile buildListTile(IconData icon, String title,
      {required VoidCallback onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('Choose Language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context).translate('English')),
                onTap: () {
                  widget.onLanguageChange(const Locale('en'));
                  Navigator.pop(context); // Đóng dialog
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).translate('Vietnamese')),
                onTap: () {
                  widget.onLanguageChange(const Locale('vi'));
                  Navigator.pop(context); // Đóng dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

}