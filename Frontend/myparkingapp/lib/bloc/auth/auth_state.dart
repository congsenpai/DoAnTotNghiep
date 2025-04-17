import 'package:myparkingapp/data/response/user_response.dart';

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

class RegisterSuccessState extends AuthState{
  final String mess;
  RegisterSuccessState(this.mess);
}

class RegisterErrorState extends AuthState{
  final String mess;
  RegisterErrorState(this.mess);
}

class GotoAcceptLocationScreenState extends AuthState{
  GotoAcceptLocationScreenState();
}


