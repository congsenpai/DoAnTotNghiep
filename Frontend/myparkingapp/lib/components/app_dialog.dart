import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';

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
  static void showDetailTransaction(BuildContext context, TransactionResponse trans) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text("Transaction Details"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Transaction ID", trans.transactionID),
            _buildInfoRow("Current Balance", trans.currentBalance.toString()),
            _buildInfoRow("Description", trans.description),
            _buildInfoRow("Type", trans.type.toString().split('.').last),
            _buildInfoRow("Status", trans.status.toString().split('.').last),
            _buildInfoRow("Wallet ID", trans.walletId),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showDetailVehicle(BuildContext context, VehicleResponse vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.directions_car, color: Colors.green),
            const SizedBox(width: 8),
            Text("Vehicle Details"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Vehicle ID", vehicle.vehicleId),
            _buildInfoRow("Vehicle Type", vehicle.vehicleType.toString().split('.').last),
            _buildInfoRow("License Plate", vehicle.licensePlate),
            _buildInfoRow("Description", vehicle.description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, softWrap: true),
          ),
        ],
      ),
    );
  }
}




