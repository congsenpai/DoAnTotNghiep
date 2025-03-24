import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/demo_data.dart';

abstract class BookingEvent{}

class BookingInitialEvent extends BookingEvent{
  final ParkingLotResponse lot;
  BookingInitialEvent( this.lot);
}

class BookingCreateInvoiceEvent extends BookingEvent{
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final DiscountResponse discount;
  final List<DiscountResponse> discounts;
  final DateTime start;
  final List<MonthInfo> months;
  final MonthInfo month;
  BookingCreateInvoiceEvent(this.discount, this.start, this.lot,
      this.slot,this.month, this.discounts, this.months);
}
class GetOderEvent extends BookingEvent{
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final DiscountResponse discount;
  final DateTime start;
  final MonthInfo monthList;
  GetOderEvent( this.lot,this.slot,this.discount,this.start,
      this.monthList);

}

class AddTransactionEvent extends BookingEvent{


}