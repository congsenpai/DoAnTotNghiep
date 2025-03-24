import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';

class InvoiceBloc extends Bloc<InvoiceEvent,InvoiceState>{
  InvoiceBloc():super(InvoiceInitialState()){
    on<InvoiceInitialEvent>(_getInvoiceBySearchAndPage);
  }

  void _getInvoiceBySearchAndPage (InvoiceInitialEvent event, Emitter<InvoiceState> emit){
    try{
      emit(InvoiceLoadingState());
      InvoiceOnPage invoiceOnPage = invoiceOnPages.firstWhere((i)=>i.page == 1);
      List<InvoiceResponse> invoices = invoiceOnPage.invoices;
      emit(InvoiceLoadedState(invoices, event.page, invoiceOnPage.pageAmount));
    }
    catch(e){
      Exception("InvoiceBloc _getInvoiceBySearchAndPage : $e");
    }
  }
}