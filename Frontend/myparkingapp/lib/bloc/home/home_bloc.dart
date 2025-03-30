// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/home/home_event.dart';
import 'package:myparkingapp/bloc/home/home_state.dart';
// import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
// import 'package:myparkingapp/data/repository/lots_repository.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc(): super(HomeInitialState()){
    on<HomeInitialEvent>(_LoadHomeScreen);

  }

  void _LoadHomeScreen( HomeInitialEvent event, Emitter<HomeState> emit ) async{
    // LotRepository lotRepository = LotRepository();
    try{
      emit(HomeLoadingState());
      // ApiResult apiResult = await lotRepository.getParkingLotBySearchAndPage('', 1);
      // int code = apiResult.code;
      // String mess = apiResult.message;
      // if(code == 200){
      //   LotOnPage lotOnPage = apiResult.result;
      //   List<ParkingLot> lots = lotOnPage.lots;
      //   emit(HomeLoadedState(lots, lots));
      // }
      // else {
      //   emit(HomeErrorState(mess));
      // }
      LotOnPage lotOnPage = demo[1];
      List<ParkingLotResponse> lots = lotOnPage.lots;
      emit(HomeLoadedState(lots, lots));

    }
    catch(e){
      Exception("_LoadHomeScreen : $e");
    }
  }
}