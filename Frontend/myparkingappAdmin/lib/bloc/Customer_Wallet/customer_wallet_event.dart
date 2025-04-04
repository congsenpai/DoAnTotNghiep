abstract class CustomerWalletEvent{}


class CWLoadingScreenEvent extends CustomerWalletEvent{
  int page;
  String search;
  CWLoadingScreenEvent(this.page, this.search);
}

// class LockOrUnlockEvent extends CustomerWalletEvent{
//   String token;
//   int page;
//   String search;
  
// }
