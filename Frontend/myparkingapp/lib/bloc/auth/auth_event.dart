abstract class AuthEvent {}
class LoginEvent extends AuthEvent{
  String userName;
  String passWord;
  LoginEvent(this.userName,this.passWord);
}

class GetUserEvent extends AuthEvent{
  String userName;
  GetUserEvent(this.userName);
}

class RegisterEvent extends AuthEvent{
  String userName;
  String passWord;
  String phoneNumber;
  String email;
  RegisterEvent(this.userName,this.passWord,this.phoneNumber,this.email);
}

class giveEmail extends AuthEvent{
  String email;
  giveEmail(this.email);
}
class giveRePassWord extends AuthEvent{
  String password;
  String token;
  giveRePassWord(this.password, this.token);
}

class GotoAcceptLocationScreenEvent extends AuthEvent {

}




