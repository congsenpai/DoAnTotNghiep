import 'package:myparkingapp/data/response/parking_lot_response.dart';

abstract class HomeState{

}

class HomeInitialState extends HomeState{}

class HomeLoadedState extends HomeState{
  final List<ParkingLotResponse> homeLots;
  final List<ParkingLotResponse> nearlyLots;
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