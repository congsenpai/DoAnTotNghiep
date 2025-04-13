import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/booking/booking_event.dart';
import 'package:myparkingapp/bloc/booking/booking_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/discount_repository.dart';
import 'package:myparkingapp/data/repository/wallet_repository.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/demo_data.dart';

import '../../data/response/discount_response.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState()) {
    on<BookingInitialInvoiceEvent>(_loadBookingScreen);
    on<GetMonthOderEvent>(_bookingCreateMonthInvoice);
    on<GetDateOderEvent>(_bookingCreateDateInvoice);
  }

  void _loadBookingScreen(
    BookingInitialInvoiceEvent event,
    Emitter<BookingState> emit,
  ) async {
    DiscountRepository discountRepository = DiscountRepository();
    WalletRepository walletRepository = WalletRepository();
    try {
      emit(BookingLoadingState());
      ApiResult discountAPI = await discountRepository.getListDiscountByLot(event.lot);
      List<DiscountResponse> discounts = discountAPI.result;
      ApiResult walletAPI = await walletRepository.getWalletByUser(event.user);
      List<MonthInfo> months = await MonthInfo.renderMonthList(DateTime.now());
      DateTime start = event.start;
      MonthInfo month = event.month;
      DiscountResponse discount = event.discount;
      List<WalletResponse> wallets = walletAPI.result;
      WalletResponse wallet = event.wallet;
      List<VehicleResponse> vehicles = event.user.vehicles;
      VehicleResponse vehicle = event.vehicle;
      emit(
        BookingLoadedState(
          discounts,
          months,
          start,
          month,
          discount,
          wallet,
          wallets,
          vehicles,
          vehicle,
        ),
      );
    } catch (e) {
      throw Exception("BookingBloc_loadBookingScreen : $e");
    }
  }

  void _bookingCreateDateInvoice(
    GetDateOderEvent event,
    Emitter<BookingState> emit,
  ) async {
    try {

      InvoiceCreatedDailyRequest invoiceCre = InvoiceCreatedDailyRequest(
        "Deposit Parking Slot",
        event.discount.discountCode,
        event.slot.slotID,
        event.vehicle.vehicleId,
        event.user.userID,
        event.wallet.walletId,
        event.slot.pricePerHour * 3,
      );
      emit(GotoInvoiceCreateDetailState(invoiceCre,null));
    } catch (e) {
      Exception(e);
    }
  }

  void _bookingCreateMonthInvoice(
    GetMonthOderEvent event,
    Emitter<BookingState> emit,
  ) async {
    try {

      double budget = 0;
      if (event.discount.discountType == DiscountType.PERCENTAGE) {
        budget = event.slot.pricePerMonth * (1 - event.discount.discountValue);
      } else {
        budget = event.slot.pricePerMonth - event.discount.discountValue;
      }


      InvoiceCreatedMonthlyRequest request = InvoiceCreatedMonthlyRequest(
        "Payment Parking Slot By Month ${event.monthList.monthName}",
        event.discount.discountCode,
        event.slot.slotID,
        event.vehicle.vehicleId,
        event.wallet.userId,
        event.wallet.walletId,
        event.monthList.start,
        event.monthList.end,
        budget,
      );

      emit(GotoInvoiceCreateDetailState(null,request));
    } catch (e) {
      Exception(e);
    }
  }
}
