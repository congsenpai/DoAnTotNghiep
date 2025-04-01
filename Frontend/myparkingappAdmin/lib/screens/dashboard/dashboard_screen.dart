
import 'dart:collection';

import 'package:flutter/material.dart';



import '../../app/localization/app_localizations.dart';
import '../../constants.dart';
import '../../dto/response/user.dart';
import '../../responsive.dart';
import '../general/header.dart';

import 'components/assets_details.dart';

class DashboardScreen extends StatefulWidget {
  final bool isAuth;
  final User user;
  final Function(Locale) onLanguageChange;
  const DashboardScreen({super.key,
   required this.isAuth, required this.user, required this.onLanguageChange,
});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
final HashSet<String> objectColumnName = HashSet.from([
  "File Name",
  "Date",
  "Budget",
  "Type Money",
  "Type"
]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: AppLocalizations.of(context).translate("Dashboard"),user: widget.user, isAuth: widget.isAuth, onLanguageChange: widget.onLanguageChange),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      // TableObject(object: demoTransactionList, objectColumnName: objectColumnName, title: 'RecentTrans',),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) AssetsDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: AssetsDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
