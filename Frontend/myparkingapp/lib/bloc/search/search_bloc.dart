import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/home/home_bloc.dart';
import 'package:myparkingapp/bloc/search/search_event.dart';
import 'package:myparkingapp/bloc/search/search_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/repository/lots_repository.dart';

import '../../data/lot_on_page.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  SearchBloc(): super(SearchScreenInitial()){
    on<SearchScreenInitialEvent>(_loadSearchScreen);
    on<SearchScreenSearchAndChosenPageEvent>(_searchScreenSearchAndChosenPage);


  }


  void _loadSearchScreen(SearchScreenInitialEvent event, Emitter<SearchState> emit )async{
    LotRepository lotRepository = LotRepository();

    try{
      emit(SearchScreenLoading());
      ApiResult apiResult = await lotRepository.getParkingLotList(event.token, '', 1);
      int code = apiResult.code;
      String mess = apiResult.message;
      if(code == 200){
        LotOnPage lotOnPage = apiResult.result;
        emit(SearchScreenLoaded(lotOnPage, ''));
      }
      else{
        emit(SearchScreenError(mess));
      }
    }
    catch(e){
      throw Exception("_LoadSearchScreen : $e");
    }
  }
  void _searchScreenSearchAndChosenPage(SearchScreenSearchAndChosenPageEvent event, Emitter<SearchState> emit )async{
    LotRepository lotRepository = LotRepository();

    try{
      emit(SearchScreenLoading());
      ApiResult apiResult = await lotRepository.getParkingLotList(event.token, event.searchText, event.page);
      int code = apiResult.code;
      String mess = apiResult.message;
      if(code == 200){
        LotOnPage lotOnPage = apiResult.result;
        emit(SearchScreenLoaded(lotOnPage, event.searchText));
      }
      else{
        emit(SearchScreenError(mess));
      }
    }
    catch(e){
      throw Exception("_LoadSearchScreen : $e");
    }
  }
}