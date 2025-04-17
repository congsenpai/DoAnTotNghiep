class ResetPassRequest{
  String userToken;
  String newPassword;

  ResetPassRequest( this.newPassword,this.userToken);

  Map<String, dynamic> toJson() {
    return {
      'userToken': userToken,
      'newPassword': newPassword,
    };
  }

}