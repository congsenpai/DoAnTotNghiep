import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';

class AppDialog {
  /// Hàm hiển thị dialog với nội dung truyền vào
  static void showErrorEvent(BuildContext context, String mess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("error")),
          ],
        ),
        content: Text(mess),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  static void showSuccessEvent(BuildContext context, String mess, {VoidCallback? onPress}) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context).translate("success")),
              ],
            ),
            content: Text(mess),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng dialog
                  if (onPress != null) onPress(); // Gọi hàm bên ngoài nếu có
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
  static void showMessage(BuildContext context, String mess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("info")),
          ],
        ),
        content: Text(mess),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
