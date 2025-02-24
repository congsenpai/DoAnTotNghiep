import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';


class TestFiles extends StatelessWidget {
  final TextEditingController editController;
  final String title;

  const TestFiles({
    super.key,
    required this.editController,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: editController,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(title),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}