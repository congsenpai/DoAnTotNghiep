import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
    required this.price, required this.current,
  });

  final double price;
  final String current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: AppLocalizations.of(context).translate("Total"),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Get.width/15,),
            children: [
              TextSpan(
                text: "(incl. VAT)",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Text(
          "$price $current",
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Get.width/15),
        ),
      ],
    );
  }
}
