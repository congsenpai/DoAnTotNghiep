import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/booking/booking_event.dart';
import 'package:myparkingapp/bloc/booking/booking_state.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/demo_data.dart';

import '../../data/response/discount_response.dart';

class BookingBloc extends Bloc<BookingEvent,BookingState>{
  BookingBloc():super(BookingInitialState()){
    on<BookingInitialInvoiceEvent>(_loadBookingScreen);
    on<GetMonthOderEvent>(_bookingCreateMonthInvoice);
    on<GetDateOderEvent>(_bookingCreateDateInvoice);
  }

  void _loadBookingScreen (BookingInitialInvoiceEvent event, Emitter<BookingState> emit) async{
    // DiscountRepository discountRepository = DiscountRepository();
    try{
      emit(BookingLoadingState());
      List<DiscountResponse> discounts = discountDemo.where((i)=>i.parkingLotId == event.lot.parkingLotID).toList();
      List<MonthInfo> months = await MonthInfo.renderMonthList(DateTime.now());
      DateTime start = event.start;
      MonthInfo month = event.month;
      DiscountResponse discount = event.discount;
      List<WalletResponse> wallets =event.wallets;
      WalletResponse wallet = event.wallet;
      List<VehicleResponse> vehicles = event.vehicles;
      VehicleResponse vehicle = event.vehicle;
      emit(BookingLoadedState(
        discounts,
        months,
        start,
        month,
        discount,
        wallet,
        wallets,
        vehicles,
        vehicle
        ));
    }
    catch (e){
      throw Exception("BookingBloc_loadBookingScreen : $e");
    }
  }
  void _bookingCreateDateInvoice(GetDateOderEvent event, Emitter<BookingState> emit) async{
    try{

      emit(BookingLoadingState());
      CreatedTransactionRequest transaction = CreatedTransactionRequest
      (
       currentBalance: event.slot.pricePerMonth,
       description: "Positer Parking Slot",
       type: Transactions.PAYMENT,
       walletId: event.wallet.walletId);


      CreatedInvoiceRequest invoiceCre = CreatedInvoiceRequest(
        totalAmount: event.slot.pricePerMonth,
        description: "Deposit Parking Slot",
        transaction: [transaction],
        discount: event.discount,
        parkingSlotName: event.slot.slotName,
        vehicle: event.vehicle,
        userID: event.wallet.userId,
        parkingLotName: event.lot.parkingLotName,
        isMonthlyTicket: true);
      emit(GotoInvoiceCreateDetailEvent(invoiceCre,transaction));

    }
    catch(e){
      Exception(e);
    }

  }
  void _bookingCreateMonthInvoice(GetMonthOderEvent event, Emitter<BookingState> emit) async{
    try{

      emit(BookingLoadingState());


      double budget = 0;
      if(event.discount.discountType == DiscountType.PERCENTAGE){
        budget = event.slot.pricePerMonth * (1- event.discount.discountValue);
      }
      else{
        budget = event.slot.pricePerMonth - event.discount.discountValue;
      }
      CreatedTransactionRequest transaction = CreatedTransactionRequest
      (
       currentBalance: budget,
       description: "Payment Parking Slot By Month ${event.monthList.monthName}",
       type: Transactions.PAYMENT,
       walletId: event.wallet.walletId);

      CreatedInvoiceRequest invoiceCre = CreatedInvoiceRequest(
        totalAmount: budget,
        description: "Payment Parking Slot By Month ${event.monthList.monthName}",
        transaction: [transaction],
        discount: event.discount,
        parkingSlotName: event.slot.slotName,
        vehicle: event.vehicle,
        userID: event.wallet.userId,
        parkingLotName: event.lot.parkingLotName,
        isMonthlyTicket: true);
      emit(GotoInvoiceCreateDetailEvent(invoiceCre,transaction));

    }
    catch(e){
      Exception(e);
    }

  }
}