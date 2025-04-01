abstract class TransactionEvent{}


class TransactionLoadingScreenEvent extends TransactionEvent{
  String token;
  int page;
  String search;
  TransactionLoadingScreenEvent(this.token, this.page, this.search);
}