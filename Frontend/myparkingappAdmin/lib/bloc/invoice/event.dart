abstract class InvoiceEvent{}


class InvoiceLoadingScreenEvent extends InvoiceEvent{
  String token;
  int page;
  String search;
  InvoiceLoadingScreenEvent(this.token, this.page, this.search);
}