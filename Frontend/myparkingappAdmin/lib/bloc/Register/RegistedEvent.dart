// ignore_for_file: file_names

abstract class RegisterEvent{}
class RegisteredEvent extends RegisterEvent{
  final String username;

  RegisteredEvent(this.username, this.password, this.repass, this.firstname,
      this.lastname, this.email, this.homeAddress,
      this.companyAddress, this.phoneNumber);

  final String password;
  final String repass;
  final String firstname;
  final String lastname;
  final String email;
  final String homeAddress;
  final String companyAddress;
  final String phoneNumber;
}

