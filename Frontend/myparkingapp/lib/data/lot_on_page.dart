import 'package:myparkingapp/data/parking_lot.dart';

class LotOnPage{
  final List<ParkingLot> lots;
  final int page;
  final int pageAmount;
  LotOnPage(this.lots,this.page,this.pageAmount);
}

final List<LotOnPage> demo = [
  LotOnPage(parkingLotsDemoPage1, 1, 3),
  LotOnPage(parkingLotsDemoPage2, 2, 3),
  LotOnPage(parkingLotsDemoPage3, 3, 3),
];