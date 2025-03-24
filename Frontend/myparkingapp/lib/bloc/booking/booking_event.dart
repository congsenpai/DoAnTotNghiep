import 'package:myparkingapp/data/response/discount.dart';
import 'package:myparkingapp/data/response/parking_lot.dart';
import 'package:myparkingapp/data/response/parking_slots.dart';
import 'package:myparkingapp/demo_data.dart';

abstract class BookingEvent{}

class BookingInitialEvent extends BookingEvent{
  final ParkingLot lot;
  BookingInitialEvent( this.lot);
}

class BookingCreateInvoiceEvent extends BookingEvent{
  final ParkingLot lot;
  final ParkingSlot slot;
  final Discount discount;
  final List<Discount> discounts;
  final DateTime start;
  final List<MonthInfo> months;
  final MonthInfo month;
  BookingCreateInvoiceEvent(this.discount, this.start, this.lot,
      this.slot,this.month, this.discounts, this.months);
}
class GetOderEvent extends BookingEvent{
  final ParkingLot lot;
  final ParkingSlot slot;
  final Discount discount;
  final DateTime start;
  final MonthInfo monthList;
  GetOderEvent( this.lot,this.slot,this.discount,this.start,
      this.monthList);

}

class AddTransactionEvent extends BookingEvent{


}