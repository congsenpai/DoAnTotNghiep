import 'package:myparkingapp/data/response/invoice_response.dart';

abstract class InvoiceState{

}

class InvoiceInitialState extends InvoiceState{

}

class InvoiceLoadingState extends InvoiceState{

  InvoiceLoadingState();
}

class InvoiceLoadedState extends InvoiceState{
  List<InvoiceResponse> invoices;
  final int page;
  final int pageAmount;
  InvoiceLoadedState(this.invoices,this.page,this.pageAmount);
}

class NoInvoiceState extends InvoiceState{
}

class InvoiceErrorState extends InvoiceState{
  String mess;
  InvoiceErrorState(this.mess);
}

class InvoiceSuccessState extends InvoiceState{
  String mess;
  InvoiceSuccessState(this.mess);
}