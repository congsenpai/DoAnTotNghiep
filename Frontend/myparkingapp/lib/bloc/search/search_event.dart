abstract class SearchEvent {}

class SearchScreenInitialEvent extends SearchEvent{
  String token;
  SearchScreenInitialEvent(this.token);
}

class SearchScreenSearchAndChosenPageEvent extends SearchEvent{
  String token;
  int page;
  String searchText;
  SearchScreenSearchAndChosenPageEvent(this.searchText,this.token, this.page);
}