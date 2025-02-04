abstract class UserEvent {}
class InitstateEvent extends UserEvent{
  final String userId;
  final String bearerToken;
  InitstateEvent(this.userId, this.bearerToken);
}
class ChangeProfileEvent extends UserEvent {
  final String userID;
  final String userName;
  final String email;
  final String phone;
  final String userImg;
  final String country;
  final String userAddress;
  final String vehicle;

  ChangeProfileEvent(this.userID,
      this.userName,
      this.email,
      this.phone,
      this.userImg,
      this.country,
      this.userAddress,
      this.vehicle);

}

