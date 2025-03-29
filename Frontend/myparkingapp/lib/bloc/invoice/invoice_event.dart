import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';

import '../../data/response/user__response.dart';

abstract class InvoiceEvent{}

class InvoiceInitialEvent extends InvoiceEvent{
  final UserResponse user;
  final String search;
  final int page;
  InvoiceInitialEvent(this.user, this.search, this.page);
}

class CreatedInvoiceEvent extends InvoiceEvent{
  final CreatedTransactionRequest tran;
  final CreatedInvoiceRequest invoice;
  CreatedInvoiceEvent(this.invoice,this.tran);

  
}