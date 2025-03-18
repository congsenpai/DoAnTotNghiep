import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/booking/booking_event.dart';
import 'package:myparkingapp/bloc/booking/booking_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/demo_data.dart';
import 'package:myparkingapp/repository/discount_repository.dart';

import '../../data/discount.dart';

class BookingBloc extends Bloc<BookingEvent,BookingState>{
  BookingBloc():super(BookingInitialState()){
    on<BookingInitialEvent>(_loadBookingScreen);
    on<BookingCreateInvoiceEvent>(_BookingCreateInvoice);

  }

  void _loadBookingScreen (BookingInitialEvent event, Emitter<BookingState> emit) async{
    DiscountRepository discountRepository = DiscountRepository();
    try{
      emit(BookingLoadingState());
      print("\n-----------------------------------error\n");
      ApiResult apiResult = await discountRepository.getListDiscountByLot(event.lot, event.token);
      List<Discount> discounts = apiResult.result;
      List<MonthInfo> months = await MonthInfo.renderMonthList(DateTime.now());
      print("\n-----------------------------------error\n");
      emit(BookingLoadedState(
        discounts,
        months,
        DateTime.now(),
        MonthInfo("March",DateTime.now(),DateTime.now()),
        discounts[0]));
    }
    catch (e){
      throw Exception("_loadBookingScreen : $e");
    }
  }
  void _BookingCreateInvoice(BookingCreateInvoiceEvent event, Emitter<BookingState> emit) async{
    try{
      emit(BookingLoadedState(event.discounts, event.months, event.start, event.month,event.discount));
    }
    catch(e){
      Exception(e);
    }

  }
}