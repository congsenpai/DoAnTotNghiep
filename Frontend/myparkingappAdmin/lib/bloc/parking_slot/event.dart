abstract class ParkingSlotEvent{}


class ParkingSlotLoadingScreenEvent extends ParkingSlotEvent{
  String token;
  int page;
  String search;
  ParkingSlotLoadingScreenEvent(this.token, this.page, this.search);
}