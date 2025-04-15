import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_event.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_state.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/invoiceRepository.dart';
import 'package:myparkingappadmin/repository/parkingLotRepository.dart';
import 'package:myparkingappadmin/repository/transactionRepository.dart';

class  DashboardBloc extends Bloc< DashboardEvent, DashboardState>{
   DashboardBloc():super(DashboardInitial()){
      on<DashboardInitialEvent>(giveDashboardByParkingLot);
   }
   void giveDashboardByParkingLot(DashboardInitialEvent event, Emitter<DashboardState> emit) async {
     try {
      emit(DashboardLoadingState());
      if(event.user.roles.contains("ADMIN")){
        InvoiceRepository invoiceRepository = InvoiceRepository();
        TransactionRepository transactionRepository = TransactionRepository();
        ApiResult invoice = await invoiceRepository.getAllInvoiceByAdmin();
        ApiResult transaction = await transactionRepository.getAllTransactions();
        if(invoice.code == 200 && transaction.code == 200){
          emit(DashboardLoadedAdminState(invoice.result, transaction.result));
        }
        else{
          emit(DashboardErrorState("Error: ${invoice.message}"));
        }
      }
      else{
        InvoiceRepository invoiceRepository = InvoiceRepository();
        ParkingLotRepository parkingLotRepository = ParkingLotRepository();
        ApiResult invoice = await invoiceRepository.getAllInvoiceByOwner(event.user.userId);
        ApiResult parkingLot = await parkingLotRepository.getParkingLotByOwner(event.user.userId);
        if(invoice.code == 200 && parkingLot.code == 200){
          emit(DashboardLoadedOwnerState(invoice.result, parkingLot.result));
        }
        else{
          emit(DashboardErrorState("Error: ${invoice.message}"));
        }
        emit(DashboardLoadedOwnerState(invoices, parkingLots));
      }
      
     } catch (e) {
       emit(DashboardErrorState(e.toString()));
     }
    
   }

}