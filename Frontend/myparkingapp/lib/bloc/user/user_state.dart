import 'package:myparkingapp/data/response/vehicle__response.dart';

abstract class UserState {}


class UserInitialState extends UserState{

}

class UserLoadingState extends UserState{

}

class UserLoadedState extends UserState{
  List<VehicleResponse> vehicles;
  UserLoadedState(this.vehicles);

}

class UserSuccessState extends UserState{
  String mess;
  UserSuccessState(this.mess);

}

class UserErrorState extends UserState{
  String mess;
  UserErrorState(this.mess);
}