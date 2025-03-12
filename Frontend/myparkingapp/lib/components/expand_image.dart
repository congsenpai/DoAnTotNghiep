import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showImageDialog(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Cho dialog trong suốt xung quanh
        child: Container(
          width: Get.width / 1.2,
          height: Get.width/2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}
