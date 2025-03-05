import 'package:myparkingapp/data/model/parkingLot.dart';
import 'package:myparkingapp/data/response/Slot/ListSlot.dart';

abstract class SlotEvent{}

class SlotInitialEvent extends SlotEvent{
  final List<FloorOfLot> floorOfLot;
  final String token;
  SlotInitialEvent(this.floorOfLot,this.token);
}

class GotoBookingScreenEvent extends SlotEvent{
  final ParkingLot parkingLot;
  final String token;
  GotoBookingScreenEvent(this.parkingLot,this.token);
}

