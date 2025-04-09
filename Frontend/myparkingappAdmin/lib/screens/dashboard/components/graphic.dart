// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_bloc.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_event.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_state.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/dashboard/components/assets_details.dart';
import 'package:myparkingappadmin/screens/dashboard/components/card_info.dart';
import 'package:myparkingappadmin/screens/dashboard/components/invoice_chart.dart';
import 'package:myparkingappadmin/screens/dashboard/components/transaction_chart.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';

class Graphic extends StatefulWidget {
  final UserResponse user;
  const Graphic({super.key, required this.user});

  @override
  State<Graphic> createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Ẩn nút back
        title: Text("Diagram"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white, // Không có màu nền
              side: BorderSide(color: Colors.black), // Không có viền// Màu chữ (tùy chỉnh)
            ),
            onPressed: (){
            context.read<DashboardBloc>().add(DashboardInitialEvent(widget.user));
            
          }, child: Text("MANAGEMENT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
          SizedBox(width: 20,),
        ],
      ),
      body: BlocConsumer<DashboardBloc,DashboardState>(
        builder: (context,state){
          if (state is DashboardLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoadedAdminState) {
            List<InvoiceResponse> invoices = state.invoices;
            double totalAmount = 0;
            for (var invoice in invoices) {
              totalAmount += invoice.totalAmount;
            }
            double commission = totalAmount * 0.2;


            List<TransactionResponse> transactions = state.transaction;
            return Container(
              height: Get.height *1.5,
              width: Get.width,
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Text("TRANSACTION MANAGEMENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        Container(
                          color: Theme.of(context).colorScheme.primary,
                          height: Get.height / 2,
                          child: TransactionBarChartWidget(data: transactions, type: TransactionType.PAYMENT ,
                        )),
                        SizedBox(height: 20),
                        Text("INVOICE MANAGEMENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        Container(
                          color: Theme.of(context).colorScheme.primary,
                          height: Get.height / 2,
                          child: InvoiceBarChartWidget(data: invoices, type: InvoiceStatus.PAID,
                        )),
                      ],)
                    ),
                  SizedBox(width: 20,),
                    
                  Expanded(flex: 2,
                    child:AssetsDetails(totalAmount, commission, totalAmount - commission),),
                ],

              ),
            );
          } 
          else if (state is DashboardLoadedOwnerState) {
            List<InvoiceResponse> invoices = state.invoices;
            double totalAmount = 0;
            for (var invoice in invoices) {
              totalAmount += invoice.totalAmount;
            }
            double commission = totalAmount * 0.2;


            List<ParkingLotResponse> lots = state.parkingLot;
            return Container(
              height: Get.height *1.5,
              width: Get.width,
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text("PARKING LOT MANAGEMENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: lots.map((e) => InforOfParkingLot(info: e)).toList(),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("INVOICE MANAGEMENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        Container(
                          color: Theme.of(context).colorScheme.primary,
                          height: Get.height / 1.5,
                          child: InvoiceBarChartWidget(data: invoices, type: InvoiceStatus.PAID,
                        )),
                        SizedBox(height: 20,),
                      ],)
                    ),
                  SizedBox(width: 20,),
                    
                  Expanded(flex: 2,
                    child:AssetsDetails(totalAmount, commission, totalAmount - commission),),
                ],

              ),
            );
          } 
          return Center(
            child: Image.asset(
              "assets/images/admin-Photoroom.jpg",
              width: Get.width /4,
              fit: BoxFit.fill,
            ),
          );
        } ,
        listener: (context, state) {
          if (state is DashboardErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        },
    )
    );
  }
}