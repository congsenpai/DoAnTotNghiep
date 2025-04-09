import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/dashboard/components/graphic.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';




import '../../app/localization/app_localizations.dart';
import '../../constants.dart';
import '../general/header.dart';


class DashboardScreen extends StatefulWidget {
  final UserResponse user;
  final Function(Locale) onLanguageChange;
  const DashboardScreen({super.key, required this.user, required this.onLanguageChange,
});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _showCamera(){
    AppDialog.camera(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed:_showCamera, icon: Icon(Icons.camera_alt_outlined, color: Colors.redAccent,))
        ],

      ),
      body: SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: AppLocalizations.of(context).translate("Dashboard"),user: widget.user, onLanguageChange: widget.onLanguageChange),
            SizedBox(height: defaultPadding),
            Container(
              height: Get.height*1.1,
              width: Get.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Graphic(user: widget.user,),
            ),
          ],
        ),
      ),
    )
    );
  }
  
}
