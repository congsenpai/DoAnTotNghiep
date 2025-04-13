
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';

abstract class UserEvent{}


class LoadedCustomerScreenEvent extends UserEvent{
  String searchCustomer;
  LoadedCustomerScreenEvent(this.searchCustomer);
}

class LoadedOwnerScreenEvent extends UserEvent{
  String searchOwner;
  LoadedOwnerScreenEvent(this.searchOwner);
}

class RegisterOwnerEvent extends UserEvent{
  CreateParkingOwnerRequest request;
  RegisterOwnerEvent(this.request);
}

class UpdateUserEvent extends UserEvent{
  String userId;
  UpdateInfoResquest request;
  UpdateUserEvent(this.request,this.userId);
}

class UpdatedStatusUserEvent extends UserEvent{
  String userId;
  UserStatus newStatus;
  UpdatedStatusUserEvent(this.userId,this.newStatus);
}

class CreateParkingOwnerEvent extends UserEvent{
  CreateParkingOwnerRequest request;
  CreateParkingOwnerEvent (this.request);   
}
