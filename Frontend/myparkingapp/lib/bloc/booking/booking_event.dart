import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';
import 'package:myparkingapp/demo_data.dart';

abstract class BookingEvent{}

// class BookingInitialEvent extends BookingEvent{
//   final ParkingLotResponse lot;
//   BookingInitialEvent( this.lot);
// }

class BookingInitialInvoiceEvent extends BookingEvent{
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final DiscountResponse discount;
  final List<DiscountResponse> discounts;
  final DateTime start;
  final List<MonthInfo> months;
  final MonthInfo month;
  final WalletResponse wallet;
  final List<WalletResponse> wallets;
  final VehicleResponse vehicle;
  final List<VehicleResponse> vehicles;
  BookingInitialInvoiceEvent(this.discount, this.start, this.lot,
      this.slot,this.month, this.discounts, this.months, this.wallet, this.wallets, this.vehicle, this.vehicles);
}
class GetMonthOderEvent extends BookingEvent{
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final DiscountResponse discount;
  final MonthInfo monthList;
  final WalletResponse wallet;
  final VehicleResponse vehicle;
  GetMonthOderEvent( this.lot,this.slot,this.discount,
      this.monthList, this.wallet, this.vehicle);
}

class GetDateOderEvent extends BookingEvent{
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final DiscountResponse discount;
  final DateTime start;
  final WalletResponse wallet;
   final VehicleResponse vehicle;
  GetDateOderEvent( this.lot,this.slot,this.discount,
      this.start, this.wallet, this.vehicle);
}