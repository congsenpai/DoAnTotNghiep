
// ignore_for_file: file_names


abstract class RegisterState{}

class RegisterInitial extends RegisterState{

}


class RegisterError extends RegisterState{
  final String message;
  RegisterError(this.message);
}

class RegisterSuccess extends RegisterState{
  final bool isRegis;
  RegisterSuccess(this.isRegis);
}