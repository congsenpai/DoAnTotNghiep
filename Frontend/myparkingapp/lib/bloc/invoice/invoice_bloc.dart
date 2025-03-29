import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/invoice_repository.dart';
import 'package:myparkingapp/data/repository/transaction_repository.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';

class InvoiceBloc extends Bloc<InvoiceEvent,InvoiceState>{
  InvoiceBloc():super(InvoiceInitialState()){
    on<InvoiceInitialEvent>(_getInvoiceBySearchAndPage);
    on<CreatedInvoiceEvent>(_createInvoice);
  }

  void _getInvoiceBySearchAndPage (InvoiceInitialEvent event, Emitter<InvoiceState> emit){
    try{
      emit(InvoiceLoadingState());
      InvoiceOnPage invoiceOnPage = invoiceOnPages.firstWhere((i)=>i.page == 1);
      List<InvoiceResponse> invoices = invoiceOnPage.invoices;
      emit(InvoiceLoadedState(invoices, event.page, invoiceOnPage.pageTotal));
    }
    catch(e){
      Exception("InvoiceBloc _getInvoiceBySearchAndPage : $e");
    }
  }

  void _createInvoice(CreatedInvoiceEvent event, Emitter<InvoiceState> emit) async{
    try{

      emit(InvoiceLoadingState());

      TransactionRepository tran = TransactionRepository();
      InvoiceRepository invoice = InvoiceRepository();
      ApiResult tranApi = await tran.createTransaction(event.tran);
      if(tranApi.code != 200){
        emit(InvoiceErrorState(tranApi.message));
      }
      else{
        ApiResult invoiceApi = await invoice.createdInvoice(event.invoice);
        if(invoiceApi.code !=200){
          emit(InvoiceErrorState(invoiceApi.message));
        }
        else{
          emit(InvoiceSuccessState("${tranApi.message} \n ${invoiceApi.message}"));
        }
      }
    }
    catch(e){
      Exception(e);
    }

  }
}