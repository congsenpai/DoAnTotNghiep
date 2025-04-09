import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_event.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String scannedCode = 'Chưa quét thành công hoặc mã qr sai';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR SCAN')),
      body: Column(
        children: [
          SizedBox(
            height: Get.height/2,
            child: MobileScanner(
              onDetect: (capture) {
                for (final barcode in capture.barcodes) {
                  final code = barcode.rawValue;
                  if (code != null && code.length > 128) {
                    setState(() {
                      scannedCode = code;
                      context.read<MainAppBloc>().add(ScannerEvent(scannedCode));
                    });
                    break; // Exit loop after processing the first valid barcode
                  }
                }
              },
            ),
          ),
          Center(child: Text('Dữ liệu quét: $scannedCode')),
        ],
      ),
    );
  }
}