abstract class CustomerParkingLotEvent{}


class CPLLoadingScreenEvent extends CustomerParkingLotEvent{
  String token;
  int page;
  String search;
  CPLLoadingScreenEvent(this.token, this.page, this.search);
}
