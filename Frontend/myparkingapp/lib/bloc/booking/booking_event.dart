import 'package:myparkingapp/data/discount.dart';
import 'package:myparkingapp/data/parking_lot.dart';
import 'package:myparkingapp/data/parking_slots.dart';
import 'package:myparkingapp/demo_data.dart';

abstract class BookingEvent{}

class BookingInitialEvent extends BookingEvent{
  final String token;
  final ParkingLot lot;
  BookingInitialEvent(this.token, this.lot);
}

class BookingCreateInvoiceEvent extends BookingEvent{
  final ParkingLot lot;
  final Slot slot;
  final Discount discount;
  final List<Discount> discounts;
  final DateTime start;
  final List<MonthInfo> months;
  final MonthInfo month;
  BookingCreateInvoiceEvent(this.discount, this.start, this.lot, this.slot, this.month, this.discounts, this.months);
}



class GetOderEvent extends BookingEvent{
  final String token;
  final ParkingLot lot;
  final Slot slot;
  final Discount discount;
  final DateTime start;
  final MonthInfo monthList;
  GetOderEvent(this.token, this.lot,this.slot,this.discount,this.start, this.monthList);

}

class AddTransactionEvent extends BookingEvent{

}