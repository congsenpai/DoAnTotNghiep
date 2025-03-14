
import 'package:myparkingapp/data/parking_slots.dart';

class DataOnFloor{
  final String floorName;
  final List<Slot> lots;
  final List<String> floorNames;

  DataOnFloor(
    this.floorName,this.lots, this.floorNames
    );
}