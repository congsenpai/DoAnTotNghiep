import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/search/search_event.dart';
import 'package:myparkingapp/bloc/search/search_state.dart';
// import 'package:myparkingapp/components/api_result.dart';
// import 'package:myparkingapp/data/repository/lots_repository.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  SearchBloc(): super(SearchScreenInitial()){
    on<SearchScreenInitialEvent>(_loadSearchScreen);
    on<SearchScreenSearchAndChosenPageEvent>(_searchScreenSearchAndChosenPage);


  }


  void _loadSearchScreen(SearchScreenInitialEvent event, Emitter<SearchState> emit )async{
    // LotRepository lotRepository = LotRepository();

    try{
      emit(SearchScreenLoading());
      // ApiResult apiResult = await lotRepository.getParkingLotBySearchAndPage('', 1);
      // int code = apiResult.code;
      // String mess = apiResult.message;
      // if(code == 200){
      //   LotOnPage lotOnPage = apiResult.result;
      //   emit(SearchScreenLoaded(lotOnPage, ''));
      // }
      // else{
      //   emit(SearchScreenError(mess));
      // }
      LotOnPage lotOnPage = demo.firstWhere((i)=>i.page == 1);
      emit(SearchScreenLoaded(lotOnPage, ''));


    }
    catch(e){
      throw Exception("_LoadSearchScreen : $e");
    }
  }
  void _searchScreenSearchAndChosenPage(SearchScreenSearchAndChosenPageEvent event, Emitter<SearchState> emit )async{
    // LotRepository lotRepository = LotRepository();

    try{
      emit(SearchScreenLoading());
      // ApiResult apiResult = await lotRepository.getParkingLotBySearchAndPage(event.searchText, event.page);
      // int code = apiResult.code;
      // String mess = apiResult.message;
      // if(code == 200){
      //   LotOnPage lotOnPage = apiResult.result;
      //   emit(SearchScreenLoaded(lotOnPage, event.searchText));
      // }
      // else{
      //   emit(SearchScreenError(mess));
      // }
      LotOnPage lotOnPage = demo.firstWhere((i)=>i.page == event.page);
      emit(SearchScreenLoaded(lotOnPage, event.searchText));
    }
    catch(e){
      throw Exception("_LoadSearchScreen : $e");
    }
  }
}