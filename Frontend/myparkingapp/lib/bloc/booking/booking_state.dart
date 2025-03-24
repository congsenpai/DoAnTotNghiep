import '../../data/response/discount_response.dart';
import '../../demo_data.dart';

abstract class BookingState{}

class BookingInitialState extends BookingState{

}

class BookingLoadingState extends BookingState{

}

class BookingLoadedState extends BookingState{
  final List<DiscountResponse> discounts;
  final List<MonthInfo> monthLists;
  final MonthInfo month;
  final DateTime start;
  final DiscountResponse discount;

  BookingLoadedState(this.discounts, this.monthLists, this.start, this.month, this.discount);

}

class BookingErrorState extends BookingState{
  String mess;
  BookingErrorState(this.mess);
}
class BookingSuccessState extends BookingState{
  String mess;
  BookingSuccessState(this.mess);
}
