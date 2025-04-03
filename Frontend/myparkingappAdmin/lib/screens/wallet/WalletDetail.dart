// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';



import '../../../../constants.dart';
import '../../../app/localization/app_localizations.dart';

class WalletDetail extends StatefulWidget {
  final String title;
  final WalletResponse object;

  const WalletDetail({
    super.key,
    required this.object,
    required this.title,
  });

  @override
  State<WalletDetail> createState() => _WalletDetailState();
}

class _WalletDetailState extends State<WalletDetail> {
  late bool _parkinglotStatus; // Biến để lưu trạng thái hợp đồng

  @override
  void initState() {
    super.initState();
    _parkinglotStatus = widget.object.status; // Gán trạng thái ban đầu từ hợp đồng
  }

  void _toggleparkinglotStatus() {
    setState(() {
      _parkinglotStatus = !_parkinglotStatus;
    });

    // Thực hiện hành động khóa/mở hợp đồng tại đây (nếu cần lưu vào backend)
    print("Hợp đồng ${_parkinglotStatus ? "được mở" : "đã khóa"}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width/1.2,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate(widget.title),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                onPressed: _toggleparkinglotStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _parkinglotStatus ? Colors.red : Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Icon(_parkinglotStatus ? Icons.lock : Icons.face_unlock_outlined),
              ),
              ],
            ),
            SizedBox(height: 16),

            // Chi tiết hợp đồng
            ObjectDetailInfo(wallet: widget.object),

            SizedBox(height: 16),

            // Button khóa/mở hợp đồng
          
          ],
        ),
      ),
    );
  }
}

// Hiển thị thông tin hợp đồng
class ObjectDetailInfo extends StatefulWidget {
  final WalletResponse wallet;
  const ObjectDetailInfo({super.key, required this.wallet});

  @override
  State<ObjectDetailInfo> createState() => _ObjectDetailInfoState();
}

class _ObjectDetailInfoState extends State<ObjectDetailInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
          columnWidths: const {
            0: FlexColumnWidth(2), // Cột 1 rộng hơn
            1: FlexColumnWidth(3), // Cột 2 rộng hơn để chứa dữ liệu
          },
          children: [
            _buildTableRow('Name', widget.wallet.name),
            _buildTableRow('note', widget.wallet.balance.toString()),
            _buildTableRow('totalSlot', widget.wallet.currency),
            _buildTableRow('status', widget.wallet.status.toString()),

          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String field, String value) {
    return TableRow(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context).translate(field),
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary)),
        ),
      ],
    );
  }
}
