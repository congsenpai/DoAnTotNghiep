

import '../../data/models/User.dart';

abstract class UserState {}

class UserInitial extends UserState {
}

class UserLoading extends UserState {
}

class UserLoaded extends UserState {
  final User userModel;
  UserLoaded(this.userModel);
}


class UserError extends UserState {
  final String message;

  UserError(this.message);
}