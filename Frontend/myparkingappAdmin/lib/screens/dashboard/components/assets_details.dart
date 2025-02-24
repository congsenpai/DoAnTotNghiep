import 'package:flutter/material.dart';


import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';
import 'chart.dart';
import '../../general/object_horizontal.dart';

class AssetsDetails extends StatelessWidget {
  // final List<ObjectHorizontal> object;
  const AssetsDetails({
    
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate("AssetsDetails"),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            Chart(),
            ObjectHorizontal(
              svgSrc: "assets/logos/xynsh-rect.svg",
              title: "ChineBank",
              amountOfObject: "0",
              numOfObject: 1328,
            ),
            ObjectHorizontal(
              svgSrc: "assets/logos/zybank-rect.svg",
              title: "ABChineBank",
              amountOfObject: "0",
              numOfObject: 1328,
            ),
            ObjectHorizontal(
              svgSrc: "assets/logos/zxbk-rect.svg",
              title: "BangKokBank",
              amountOfObject: "0",
              numOfObject: 1328,
            ),
          ],
        ),
      ),
    );
  }
}
