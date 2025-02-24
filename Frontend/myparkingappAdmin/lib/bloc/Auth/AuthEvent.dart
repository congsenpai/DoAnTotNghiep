// ignore_for_file: file_names

abstract class AuthEvent{}
class AuthenticateEvent extends AuthEvent{
  final String username;
  final String password;
  AuthenticateEvent(this.username,this.password);
}
// class RegisterEvent extends AuthEvent{
//   final String username;
//
//   RegisterEvent(this.username, this.password, this.repass, this.firstname,
//       this.lastname, this.email, this.homeAddress,
//       this.companyAddress, this.phoneNumber);
//
//   final String password;
//   final String repass;
//   final String firstname;
//   final String lastname;
//   final String email;
//   final String homeAddress;
//   final String companyAddress;
//   final String phoneNumber;
// }

class ForgetPassWordEvent extends AuthEvent{
  final String email;
  ForgetPassWordEvent(this.email);
}

