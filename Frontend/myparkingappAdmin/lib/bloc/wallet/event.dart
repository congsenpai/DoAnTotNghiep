abstract class WalletEvent{}


class WalletLoadingScreenEvent extends WalletEvent{
  String token;
  int page;
  String search;
  WalletLoadingScreenEvent(this.token, this.page, this.search);
}