abstract class SearchEvent {}

class SearchScreenInitialEvent extends SearchEvent{
  SearchScreenInitialEvent();
}

class SearchScreenSearchAndChosenPageEvent extends SearchEvent{
  int page;
  String searchText;
  SearchScreenSearchAndChosenPageEvent(this.searchText, this.page);
}