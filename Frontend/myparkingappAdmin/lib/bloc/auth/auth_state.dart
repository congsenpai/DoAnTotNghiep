
// ignore_for_file: file_names





import 'package:myparkingappadmin/data/dto/response/user_response.dart';

abstract class AuthState{}

class AuthInitial extends AuthState{

}
class AuthSuccess extends AuthState{
  final UserResponse user;
  final String token;
  AuthSuccess(this.user, this.token);
}

class AuthError extends AuthState{
  final String message;
  AuthError(this.message);
}

class RegisterSuccess extends AuthState{
  final bool isRegis;
  RegisterSuccess(this.isRegis);
}