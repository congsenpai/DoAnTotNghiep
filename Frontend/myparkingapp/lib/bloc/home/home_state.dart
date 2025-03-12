import 'package:myparkingapp/data/parking_lot.dart';

import '../../data/lot_on_page.dart';
import '../../repository/lots_repository.dart';

abstract class HomeState{

}

class HomeInitialState extends HomeState{}

class HomeLoadedState extends HomeState{
  final List<ParkingLot> homeLots;
  final List<ParkingLot> nearlyLots;
  HomeLoadedState(this.homeLots,this.nearlyLots);
}
class HomeLoadingState extends HomeState{

}
class HomeErrorState extends HomeState{
  final String mess;
  HomeErrorState(this.mess);
}

class GotoSearchScreen extends HomeState{
  final LotOnPage lotOnPage;
  GotoSearchScreen(this.lotOnPage);
}