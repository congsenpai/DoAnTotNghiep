// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/main_screen.dart';
import 'package:myparkingapp/screens/profile/profile_screen.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
class TransactionInfo extends StatefulWidget {
  final UserResponse user;
  final String name;
  final double amount;
  final String note;
  const TransactionInfo({super.key, required this.name, required this.amount, required this.note, required this.user});

  @override
  State<TransactionInfo> createState() => _TransactionInfoState();
}

class _TransactionInfoState extends State<TransactionInfo> {
  String responseCode = '200';

  Future<void> onPayment() async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url:
      'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'W6YEW49O', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: " Recharge ${widget.amount} VND to this wallet ${widget.name} ", //order info, default is Pay Order
      amount: widget.amount,
      returnUrl:
      'xxxxxx', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey: 'WSBCHHFZBEGYEQNOQHVKLNCGZVHQTHMU', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType
          .HMACSHA512, //hash type. Default is HMACSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
    );
    await VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        setState(() {
          responseCode = params['vnp_ResponseCode'];
        });
      },
      onPaymentError: (params) {
        setState(() {
          responseCode = 'Error';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate('VNPay'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Table(
              border: TableBorder.all(color: Colors.grey), // Viền bảng
              columnWidths: const {
                0: FlexColumnWidth(1), // Cột 1 chiếm 1 phần
                1: FlexColumnWidth(2), // Cột 2 chiếm 2 phần
              },
              children: [
                _buildTableRow(AppLocalizations.of(context).translate("WalletName"), widget.name),
                _buildTableRow(AppLocalizations.of(context).translate("Money"), "${widget.amount} VND"),
                _buildTableRow(AppLocalizations.of(context).translate("Note"), widget.note),
              ],
            ),
            const SizedBox(height: 20),
            responseCode == "00"
            ? Infomation(color: Colors.green,icon: Icons.check, text: 'Successfully transaction',) // Thêm giá trị màu hợp lệ
            : responseCode == "200"
                ? Infomation(color: Colors.yellow,icon: Icons.closed_caption_off_outlined, text: 'Loading transaction',) 
                : Infomation(color: Colors.red,icon: Icons.check, text: 'Failed transaction',), 
            
            const SizedBox(height: 20),

            responseCode == '200' 
            ? ElevatedButton(
              onPressed: onPayment,
              child: Text(AppLocalizations.of(context).translate('Payment now')),
            ): responseCode == '00' 
            ?  ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              },
              child: Text(AppLocalizations.of(context).translate('Return Main Screen')),
            ) : SizedBox(height: 20)
            
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }
  
}

class Infomation extends StatelessWidget {
  final Color? color;
  final IconData? icon; // Đổi từ Icon? -> IconData?
  final String text;
  
  const Infomation({super.key, required this.color, this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0, // Đặt độ nâng (bóng)
      color: Colors.black.withOpacity(0.5), // Màu nền
      borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
      child: Container(
        width: MediaQuery.of(context).size.width / 2, // Thay thế Get.width
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            if (icon != null) Icon(icon, color: color), // Kiểm tra null trước khi hiển thị icon
            Text(
              AppLocalizations.of(context).translate(text),
              style: TextStyle(color: color), // Thêm màu chữ để dễ đọc
            ),
          ],
        ),
      ),
    );
  }
}


