import 'package:myparkingapp/data/data_on_floor.dart';
import 'package:myparkingapp/data/parking_lot.dart';

abstract class LotDetailEvent {}
class LotDetailScreenInitialEvent extends LotDetailEvent{
  final String token;
  final ParkingLot parkingLot;
  LotDetailScreenInitialEvent(this.token, this.parkingLot);
}
class LoadListLotsEvent extends LotDetailEvent{
  final String token;
  final String floorName;
  final ParkingLot parkingLot;
  LoadListLotsEvent(this.token,this.floorName, this.parkingLot);
}

class GotoBookingScreenEvent extends LotDetailEvent{

}