import 'package:flutter/material.dart';

import '../../../app/localization/app_localizations.dart';

class TestFiles extends StatelessWidget {
  final TextEditingController editController;
  final String title;
  final FocusNode focusNode = FocusNode(); // Thêm FocusNode

  TestFiles({super.key, required this.editController, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: editController,
        focusNode: focusNode, // Gán FocusNode vào đây
        obscureText: title.toLowerCase().contains("Password"), // Ẩn nếu là mật khẩu
        onTap: () {
          if (!focusNode.hasFocus) {
            focusNode.requestFocus(); // Đảm bảo được focus
          }
        },
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(title),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}