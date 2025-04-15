import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';

import '../../data/response/user_response.dart';

abstract class InvoiceEvent{}

class InvoiceInitialEvent extends InvoiceEvent{
  final String search;
  final int page;
  InvoiceInitialEvent( this.search, this.page);
}

class CreatedInvoiceEvent extends InvoiceEvent{
  InvoiceCreatedDailyRequest? invoiceD;
  InvoiceCreatedMonthlyRequest? invoiceM;
  CreatedInvoiceEvent(this.invoiceD,this.invoiceM);
}