// ignore_for_file: file_names

import 'package:myparkingapp/data/model/parkingSlot.dart';


class FloorOfLot {
  final String floorName;
  final ListSlot lists;

  FloorOfLot(this.floorName, this.lists);

  @override
  String toString() {
    return 'FloorOfLot(floorName: $floorName, car: ${lists.carSlot.length} moto: ${lists.motoSlot.length})';
  }
}

class ListSlot{
  final List<ParkingSlot> motoSlot;
  final List<ParkingSlot> carSlot;

  ListSlot(this.carSlot,this.motoSlot);
}

