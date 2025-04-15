import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/screens/invoice/components/object_row.dart';
import 'package:myparkingapp/screens/invoice/components/total_price.dart';
import 'package:myparkingapp/screens/invoice/invoice_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  final InvoiceResponse invoice;
  
  const InvoiceDetailsScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>InvoiceScreen())
                )
              }
          ),
        ),
        title: Text(AppLocalizations.of(context).translate("Invoice Detail")),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_invoice.png", // Đường dẫn đến GIF trong thư mục assets
              fit: BoxFit.cover,
            ),
          ),
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width/30),
                ObjectRow(title: "parkingLotName",content: invoice.parkingLotName),
                SizedBox(height: Get.width/30),
                ObjectRow(title: "parkingSlotName",content: invoice.parkingSlotName),
                SizedBox(height: Get.width/30),
                ObjectRow(title: "Invoice Type",content: invoice.isMonthlyTicket ? "Month":"Date"),
                SizedBox(height: Get.width/30),

                Text(
                  AppLocalizations.of(context).translate("Description"),
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  invoice.description,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Get.width/30),
                invoice.discount !=null ?
                PrimaryButton(
                      text: "${AppLocalizations.of(context).translate("Discount")} : ${invoice.discount!.discountCode}",
                      press: () {
                        AppDialog.showDetailDiscount(context, invoice.discount!);
                      },
                    ):
                SizedBox(height: Get.width/30),
                PrimaryButton(
                  text: "${AppLocalizations.of(context).translate("Vehicle")} : ${invoice.vehicle.licensePlate}",
                  press: () {
                    AppDialog.showDetailVehicle(context, invoice.vehicle);
                  },
                ),
                SizedBox(height: 10),
                Spacer(),
                TotalPrice(price: invoice.totalAmount, current: '',),
                SizedBox(height: Get.width/10),
              ],
            ),
          ),
        
      
        ],
        ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final GestureTapCallback press;

  const PrimaryButton({super.key, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding = const EdgeInsets.symmetric(vertical: 16);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
              style: TextButton.styleFrom(
                padding: verticalPadding,
                backgroundColor: const Color(0xFF22A45D),
              ),
              onPressed: press,
              child: buildText(context),
            ),
    );
  }

  Text buildText(BuildContext context) {
    return Text(
      AppLocalizations.of(context).translate(text).toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}