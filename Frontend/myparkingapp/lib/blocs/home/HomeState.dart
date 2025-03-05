


// ignore_for_file: file_names

import 'package:myparkingapp/data/model/image.dart';
import 'package:myparkingapp/data/model/parkingLot.dart';

import '../../data/model/discount.dart';

abstract class HomeState{
}

class HomeInitialState extends HomeState{


}
class HomeStandardState extends HomeState{
  List<ParkingLot> lots;
  List<Discount> discounts;
  HomeStandardState(this.lots,this.discounts);
}

class HomeLoadedState extends HomeState{
  List<ParkingLot> parkingLots;
  int page;
  int pageAmount;
  HomeLoadedState(this.parkingLots,this.page, this.pageAmount);
}
class HomeLoadedStateRecently extends HomeState{
  List<ParkingLot> recentlyYouLots;
  int page;
  int pageAmount;
  HomeLoadedStateRecently(this.recentlyYouLots,this.page,this.pageAmount);
}

class GotoDetailLotScreenState extends HomeState{
  List<Images> image;
  ParkingLot parkingLot;
  GotoDetailLotScreenState(this.image,this.parkingLot);
}
class HomeErrorState extends HomeState{
  String message;
  HomeErrorState(this.message);
}
class HomeScreenLoading extends HomeState{

}

