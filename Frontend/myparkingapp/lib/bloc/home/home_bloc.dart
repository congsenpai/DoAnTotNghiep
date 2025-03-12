import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/home/home_event.dart';
import 'package:myparkingapp/bloc/home/home_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/parking_lot.dart';
import 'package:myparkingapp/repository/slot_repository.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc(): super(HomeInitialState()){
    on<HomeInitialEvent>(_LoadHomeScreen);

  }

  void _LoadHomeScreen( HomeInitialEvent event, Emitter<HomeState> emit ) async{
    emit(HomeLoadingState());
    LotRepository lotRepository = LotRepository();
    try{
      ApiResult apiResult = await lotRepository.getParkingLotList(event.token, '', 1);
      int code = apiResult.code;
      String mess = apiResult.message;
      if(code == 200){
        LotOnPage lotOnPage = apiResult.result;
        List<ParkingLot> lots = lotOnPage.lots;
        emit(HomeLoadedState(lots, lots));
      }
      else {
        emit(HomeErrorState(mess));
      }
    }
    catch(e){
      Exception("_LoadHomeScreen : $e");
    }
  }
}