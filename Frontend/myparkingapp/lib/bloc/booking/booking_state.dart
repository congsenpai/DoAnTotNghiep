import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

import '../../data/response/discount_response.dart';
import '../../demo_data.dart';

abstract class BookingState{}

class BookingInitialState extends BookingState{

}

class BookingLoadingState extends BookingState{

}

class BookingLoadedState extends BookingState{
  final List<DiscountResponse> discounts;
  final List<MonthInfo> monthLists;
  final MonthInfo month;
  final DateTime start;
  final DiscountResponse discount;
  final WalletResponse wallet;
  final List<WalletResponse> wallets;
  final List<VehicleResponse> vehicles;
  final VehicleResponse vehicle;

  BookingLoadedState(this.discounts, this.monthLists, this.start, this.month, this.discount, this.wallet, this.wallets, this.vehicles, this.vehicle);

}

class BookingErrorState extends BookingState{
  String mess;
  BookingErrorState(this.mess);
}
class BookingSuccessState extends BookingState{
  final InvoiceCreatedDailyRequest invoice;
  final CreatedTransactionRequest tran;
  String mess;
  BookingSuccessState(this.mess, this.invoice, this.tran);
}

class GotoInvoiceCreateDetailState extends BookingState{
  InvoiceCreatedDailyRequest? invoiceD;
  InvoiceCreatedMonthlyRequest? invoiceM;
  GotoInvoiceCreateDetailState (this.invoiceD,this.invoiceM);
}
