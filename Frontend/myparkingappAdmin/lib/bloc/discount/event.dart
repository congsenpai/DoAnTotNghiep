abstract class DiscountEvent{}


class DiscountLoadingScreenEvent extends DiscountEvent{
  String token;
  int page;
  String search;
  DiscountLoadingScreenEvent(this.token, this.page, this.search);
}