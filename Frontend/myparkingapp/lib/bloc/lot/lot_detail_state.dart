import 'package:myparkingapp/data/data_on_floor.dart';

abstract class LotDetailState{

}
class LotDetailInitial extends LotDetailState{

}
class LoadingLotDetailState extends LotDetailState{

}
class LoadedLotDetailState extends LotDetailState{
  final DataOnFloor dataOnFloor;
  LoadedLotDetailState(this.dataOnFloor);
}
class LotDetailErrorScreen extends LotDetailState{
  final String mess;
  LotDetailErrorScreen(this.mess);
}