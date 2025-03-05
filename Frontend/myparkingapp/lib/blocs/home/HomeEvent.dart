
// ignore_for_file: file_names

import 'package:myparkingapp/data/model/user.dart';

import '../../data/model/parkingLot.dart';

abstract class HomeEvent{}
class HomeInitial extends HomeEvent{
  String token;
  HomeInitial(this.token);

}
class HomeLoadParkingLotEvent extends HomeEvent{
  int page;
  String search;
  String token;
  HomeLoadParkingLotEvent(this.page,this.search,this.token);
}
class HomeLoadParkingLotOrderedEvent extends HomeEvent{
  User user;
  int page;
  String search;
  String token;
  HomeLoadParkingLotOrderedEvent(this.user,this.page,this.search,this.token);
}
class HomeLoadDiscountListEvent extends HomeEvent{
  int page;
  String search;
  String token;
  HomeLoadDiscountListEvent (this.page, this.search, this.token);
}
class GotoDetailLotEvent extends HomeEvent{
  ParkingLot parkingLot;
  String token;
  GotoDetailLotEvent(this.parkingLot, this.token);
}
