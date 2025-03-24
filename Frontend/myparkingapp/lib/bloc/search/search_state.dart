
import 'package:myparkingapp/data/response/parking_lot.dart';


abstract class SearchState{}

class SearchScreenInitial extends SearchState{


}

class SearchScreenLoading extends SearchState{

}

class SearchScreenLoaded extends SearchState{
  final LotOnPage lotOnPage;
  final String searchText;
  SearchScreenLoaded(this.lotOnPage, this.searchText);
}

class SearchScreenError extends SearchState{
  final String mess;
  SearchScreenError(this.mess);
}