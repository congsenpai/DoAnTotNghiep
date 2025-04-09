import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

abstract class UserState {}


class UserInitialState extends UserState{

}

class UserLoadingState extends UserState{

}

class UserLoadedState extends UserState{
  UserResponse user;
  List<VehicleResponse> vehicles;
  UserLoadedState(this.vehicles, this.user);

}

class UserSuccessState extends UserState{
  String mess;
  UserSuccessState(this.mess);

}

class UserErrorState extends UserState{
  String mess;
  UserErrorState(this.mess);
}