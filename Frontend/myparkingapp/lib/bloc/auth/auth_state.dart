import 'package:myparkingapp/data/response/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState{

}

class AuthLoadingState extends AuthState{

}

class AuthLoadedState extends AuthState{
}

class AuthSuccessState extends AuthState{
  final String mess;
  AuthSuccessState(this.mess);
}

class AuthErrorState extends AuthState{
  final String mess;
  AuthErrorState(this.mess);
}

class GotoAcceptLocationScreenState extends AuthState{
  final User user;
  GotoAcceptLocationScreenState(this.user);
}


