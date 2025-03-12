import 'package:flutter/material.dart';

class AppDialog {
  /// Hàm hiển thị dialog với nội dung truyền vào
  static void showMessage(BuildContext context, String mess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            const Text('Thông báo'),
          ],
        ),
        content: Text(mess),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
