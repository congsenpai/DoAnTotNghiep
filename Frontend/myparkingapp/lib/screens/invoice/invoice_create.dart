// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import 'package:myparkingapp/screens/invoice/components/object_row.dart';
import 'package:myparkingapp/screens/invoice/components/total_price.dart';
import 'package:myparkingapp/screens/invoice/invoice_screen.dart';

class InvoiceCreateScreen extends StatelessWidget {
  final CreatedInvoiceRequest invoice;
  final CreatedTransactionRequest tran;
  final UserResponse user; 
  
  
  const InvoiceCreateScreen({super.key, required this.invoice, required this.tran, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate("Your Orders")),
      ),
      body: BlocConsumer<InvoiceBloc,InvoiceState>
      (builder: (context,state) {
        if(state is InvoiceLoadingState){
          return Center(
              child: CircularProgressIndicator(),
          );
        }
        return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_invoice.png", // Đường dẫn đến GIF trong thư mục assets
              fit: BoxFit.cover,
            ),
          ),
           Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    SizedBox(height: Get.width/30),
                    ObjectRow(title: "parkingLotName",content: invoice.parkingLotName), // tran vien 
                    SizedBox(height: Get.width/30),
                    ObjectRow(title: "parkingSlotName",content: invoice.parkingSlotName),
                    SizedBox(height: Get.width/30),
                    ObjectRow(title: "Booking by",content: invoice.isMonthlyTicket ? "Month":"Date"),
                    SizedBox(height: Get.width/30),

                    Text(
                        AppLocalizations.of(context).translate("Description :"),
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        invoice.description,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    PrimaryButton(
                      text: "Discount",
                      press: () {
                        AppDialog.showDetailDiscount(context, invoice.discount);
                      },
                    ),
                    SizedBox(height: Get.width/30),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(  // Dùng Column để chứa danh sách nút bấm
                              children: List.generate(invoice.transaction.length, (index) {
                                return PrimaryButton(
                                  text: invoice.transaction[index].type.name,
                                  press: () {
                                    AppDialog.showCreatedTransaction(context, invoice.transaction[index]);
                                  },
                                );
                              }),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            flex: 1,
                            child: PrimaryButton(
                              text: "${invoice.vehicle.licensePlate} ",
                              press: () {
                                AppDialog.showDetailVehicle(context, invoice.vehicle);
                              },
                            ),
                          ),
                        ],
                      ),
                    Spacer(),
                    const TotalPrice(price: 20),
                    SizedBox(height: Get.width/30),
                    PrimaryButton(
                      text: "PayMent",
                      press: () {
                        context.read<InvoiceBloc>().add(CreatedInvoiceEvent(invoice,tran));
                      },
                    ),
                    SizedBox(height: Get.width/30),
                  ],
                ),
              ),
            
   
        ],
      );
       
      },
      
       listener: (context,state){
        if(state is InvoiceErrorState){
          AppDialog.showErrorEvent(context, state.mess);
        }

        if(state is InvoiceSuccessState){
          AppDialog.showSuccessEvent(context, state.mess, onPress: (){
            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>InvoiceScreen(user: user,),
                                  ),
                                );
          }
          );
        }
    })

      
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
