import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/main_screen.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
              backgroundColor: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.close, color: Colors.white),
            onPressed: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>MainScreen())
              )
            }
          ),
        ),
        title: Text(AppLocalizations.of(context).translate("My Profile")),
      ),
      body: Body(),
    );
  }
}
