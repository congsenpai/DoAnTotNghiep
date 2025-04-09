import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

abstract class UserEvent {}

class UpdateUserInfo extends UserEvent{
  UserResponse user;
  UpdateUserRequest newUser;
  UpdateUserInfo(this.user,this.newUser);
}

class LoadUserDataEvent extends UserEvent{
  String userId;
  LoadUserDataEvent(this.userId);
}

class ChangePassword extends UserEvent{
  UserResponse user;
  String oldPass;
  String newPass;
  ChangePassword(this.newPass,this.oldPass,this.user);
}

class AddNewVehicle extends UserEvent{
  UserResponse user;
  VehicleResponse vehicle;
  AddNewVehicle(this.user, this.vehicle);

}

class DeleteVehicle extends UserEvent{
  String vehicleID;
  DeleteVehicle(this.vehicleID);
}