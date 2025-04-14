import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/invoice_repository.dart';
import 'package:myparkingapp/data/repository/transaction_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class InvoiceBloc extends Bloc<InvoiceEvent,InvoiceState>{
  InvoiceBloc():super(InvoiceInitialState()){
    on<InvoiceInitialEvent>(_getInvoiceBySearchAndPage);
    on<CreatedInvoiceEvent>(_createInvoice);
  }
  void _getInvoiceBySearchAndPage (InvoiceInitialEvent event, Emitter<InvoiceState> emit) async{
    try{
      emit(InvoiceLoadingState());
      UserRepository userRepository = UserRepository();
      ApiResult userApi =  await userRepository.getMe();
      UserResponse user = userApi.result;
      InvoiceOnPage invoiceOnPage = invoiceOnPages.firstWhere((i)=>i.page == 1);
      List<InvoiceResponse> invoices = invoiceOnPage.invoices;
      emit(InvoiceLoadedState(invoices, event.page, invoiceOnPage.pageTotal, user));
    }
    catch(e){
      Exception("InvoiceBloc _getInvoiceBySearchAndPage : $e");
    }
  }
  void _createInvoice(CreatedInvoiceEvent event, Emitter<InvoiceState> emit) async{
    try{
      emit(InvoiceLoadingState());
      InvoiceRepository invoice = InvoiceRepository();
      late ApiResult invoiceApi;
      invoiceApi = await invoice.createdInvoice(event.invoiceD,event.invoiceM);



      if(invoiceApi.code !=200){
        emit(InvoiceErrorState(invoiceApi.message));
      }
      else{
        emit(InvoiceSuccessState(" ${invoiceApi.message}"));
      }
    }
    catch(e){
      Exception(e);
    }

  }
}