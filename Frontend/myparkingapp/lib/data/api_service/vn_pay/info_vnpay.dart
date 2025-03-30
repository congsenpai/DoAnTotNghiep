import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
class Example extends StatefulWidget {
  final String name;
  final double amount;
  final String note;
  const Example({super.key, required this.name, required this.amount, required this.note});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
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
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate('Thanh toán VNPay'))),
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
                _buildTableRow(AppLocalizations.of(context).translate("Tên"), widget.name),
                _buildTableRow(AppLocalizations.of(context).translate("Số tiền"), "${widget.amount} VND"),
                _buildTableRow(AppLocalizations.of(context).translate("Ghi chú"), widget.note),
              ],
            ),
            const SizedBox(height: 20),
            responseCode == "00" 
              ? Icon(Icons.check_circle_outline, color: Colors.greenAccent) 
              : responseCode == "200" 
                ? Icon(Icons.punch_clock_outlined, color: Colors.yellowAccent) 
                : Icon(Icons.cancel_outlined, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              responseCode == '00' 
                ? AppLocalizations.of(context).translate('Thanh toán thành công') 
                : responseCode == '200' 
                  ? AppLocalizations.of(context).translate('Chờ thanh toán') 
                  : AppLocalizations.of(context).translate('Thanh toán thất bại'),
              style: TextStyle(
                fontSize: 18, 
                color: responseCode == '00' 
                  ? Colors.green 
                  : responseCode == '200' 
                    ? Colors.yellow 
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPayment,
              child: Text(AppLocalizations.of(context).translate('Thanh toán ngay')),
            ),
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