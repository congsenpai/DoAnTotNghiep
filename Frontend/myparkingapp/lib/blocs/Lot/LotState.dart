

// ignore_for_file: file_names

import 'package:myparkingapp/data/model/image.dart';
import 'package:myparkingapp/data/model/parkingSlot.dart';
import 'package:myparkingapp/data/response/Slot/ListSlot.dart';

abstract class LotState {}

class LotInitialState extends LotState{

}
class GotoSlotScreenState extends LotState{
  String token;
  List<FloorOfLot> listSlot;
  GotoSlotScreenState(this.token,this.listSlot);
}
class AddingFavoriteState extends LotState{
  ParkingSlot parkingSlot;
  AddingFavoriteState(this.parkingSlot);
}
class ErrorLotState extends LotState{
  String message;
  ErrorLotState( this.message);
}
class LotLoadedState extends LotState{
  Images image;
  LotLoadedState(this.image);
}