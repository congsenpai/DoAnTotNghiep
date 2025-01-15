// ignore_for_file: file_names, use_super_parameters

import 'package:flutter/material.dart';

import '../app/locallization/app_localizations.dart';

class Trash extends StatelessWidget {
  final Function(Locale) onLanguageChange;

  const Trash({Key? key, required this.onLanguageChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('hello')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).translate('welcome'),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onLanguageChange(const Locale('en')),
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () => onLanguageChange(const Locale('vi')),
              child: const Text('Tiếng Việt'),
            ),
          ],
        ),
      ),
    );
  }
}
