

// ignore_for_file: file_names

import 'package:myparkingapp/data/model/image.dart';

import '../../data/model/parkingLot.dart';

abstract class LotEvent {

}
class LotInitialEvent extends LotEvent{}

class GotoSlotScreenEvent extends LotEvent{
  String token;
  ParkingLot parkingLot;
  GotoSlotScreenEvent(
      this.token, this.parkingLot);
}
class AddingFavoriteEvent extends LotEvent{
  String token;
  bool isActive;
  AddingFavoriteEvent(
      this.token, this.isActive);
}
class ChangeImageEvent extends LotEvent{
  Images image;
  ChangeImageEvent(this.image);
}
