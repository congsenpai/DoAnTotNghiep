abstract class CustomerWalletEvent{}


class CWLoadingScreenEvent extends CustomerWalletEvent{
  String token;
  int page;
  String search;
  CWLoadingScreenEvent(this.token, this.page, this.search);
}
