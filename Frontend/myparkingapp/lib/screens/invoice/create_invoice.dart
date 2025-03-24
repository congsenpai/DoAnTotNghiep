import 'package:flutter/material.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/screens/invoice/components/object_row.dart';
import 'package:myparkingapp/screens/invoice/components/total_price.dart';

class OrderDetailsScreen extends StatelessWidget {
  final InvoiceResponse invoice;
  
  const OrderDetailsScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Your Orders"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              
              
              ObjectRow(title: "parkingLotName",content: invoice.parkingLotName),
              const SizedBox(height: 8),
              ObjectRow(title: "parkingSlotName",content: invoice.parkingSlotName),
              const SizedBox(height: 8),
              ObjectRow(title: "parkingSlotName",content: invoice.isMonthlyTicket ? "Month":"Date"),
              const SizedBox(height: 8),
              ObjectRow(title: "parkingSlotName",content: invoice),
              const SizedBox(height: 8),

              const TotalPrice(price: 20),
              const SizedBox(height: 32),
              PrimaryButton(
                text: "",
                press: () {
                  
                },
              ),
            ],
          ),
        ),
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
      text.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
