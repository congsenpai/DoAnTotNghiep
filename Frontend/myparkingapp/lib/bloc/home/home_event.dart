abstract class HomeEvent{}

class HomeInitialEvent extends HomeEvent{
  String token;
  HomeInitialEvent(this.token);
}

class GotoSearchScreenEvent extends HomeEvent{
  String token;
  GotoSearchScreenEvent(this.token);
}