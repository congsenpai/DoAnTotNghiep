
// ignore_for_file: file_names

import '../../models/user.dart';

abstract class AuthState{}

class AuthInitial extends AuthState{

}
class AuthSuccess extends AuthState{
  final User user;
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