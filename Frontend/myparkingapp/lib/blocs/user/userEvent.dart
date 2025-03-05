// ignore_for_file: file_names

import 'package:myparkingapp/data/model/user.dart';

abstract class UserEvent{}

class InitialEvent extends UserEvent{
  InitialEvent();
}

class UpdateUser extends UserEvent{
  final User user;
  final String token;
  UpdateUser(this.user,this.token);
}



