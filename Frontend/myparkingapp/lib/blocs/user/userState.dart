// ignore_for_file: file_names
import 'package:myparkingapp/data/model/user.dart';

abstract class UserState {}
class UserInitialState extends UserState {
}
class UserLoadingState extends UserState {
}
class UserLoadedState extends UserState {
  final User userModel;
  UserLoadedState(this.userModel);
}
class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}