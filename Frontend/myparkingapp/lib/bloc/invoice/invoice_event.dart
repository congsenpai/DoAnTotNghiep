import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';

import '../../data/response/user_response.dart';

abstract class InvoiceEvent{}

class InvoiceInitialEvent extends InvoiceEvent{
  final int page;
  InvoiceInitialEvent( this.page);
}

class CreatedInvoiceEvent extends InvoiceEvent{
  InvoiceCreatedDailyRequest? invoiceD;
  InvoiceCreatedMonthlyRequest? invoiceM;
  CreatedInvoiceEvent(this.invoiceD,this.invoiceM);
}

class CreatedPaymentInvoiceEvent extends InvoiceEvent{
  PaymentDailyRequest invoice;
  CreatedPaymentInvoiceEvent(this.invoice);
}

class GetCurrentInvoiceEvent extends InvoiceEvent{
  String userID;
  GetCurrentInvoiceEvent(this.userID);
}

class GetInvoiceByIDEvent extends InvoiceEvent{
  String invoiceID;
  GetInvoiceByIDEvent(this.invoiceID);
}