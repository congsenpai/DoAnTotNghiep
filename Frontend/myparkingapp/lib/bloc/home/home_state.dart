import 'package:myparkingapp/data/response/parking_lot.dart';
import '../../data/repository/lots_repository.dart';

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