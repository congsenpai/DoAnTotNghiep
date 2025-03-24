import 'package:myparkingapp/data/response/invoice.dart';

abstract class InvoiceState{

}

class InvoiceInitialState extends InvoiceState{

}

class InvoiceLoadingState extends InvoiceState{

  InvoiceLoadingState();
}

class InvoiceLoadedState extends InvoiceState{
  List<Invoice> invoices;
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