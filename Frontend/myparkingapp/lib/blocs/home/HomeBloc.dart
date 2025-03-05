

// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/data/model/image.dart';
import 'package:myparkingapp/data/response/apiResponse.dart';
import 'package:myparkingapp/blocs/home/HomeEvent.dart';
import 'package:myparkingapp/blocs/home/HomeState.dart';
import 'package:myparkingapp/data/model/discount.dart';
import 'package:myparkingapp/repository/discountRepository.dart';
import 'package:myparkingapp/repository/imageRepository.dart';
import 'package:myparkingapp/repository/parkingLotRepository.dart';

import '../../data/model/parkingLot.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc():super(HomeInitialState()){
    on<HomeLoadParkingLotEvent>(_giveLotList);
    on<HomeInitial>(_giveListHomeStandard);
    on<GotoDetailLotEvent>(_gotoDetailLotScreen);

  }

  void _giveLotList(HomeLoadParkingLotEvent event, Emitter<HomeState> emit) async{
    ParkingLotRepository parkingLotRepository = ParkingLotRepository();
    try{
      APIResult result = await parkingLotRepository.giveParkingLotByPageAndSearch(event.page, event.token, event.search);

      int code = result.code;
      String message = result.message;
      if(code ==200){
        List<ParkingLot> parkingLots = result.result;
        emit(HomeLoadedState(parkingLots, 0, 1));
      }
      else{
        emit(HomeErrorState(message));
      }
    }
    catch(e){
      throw Exception("_giveLotList $e");
    }
  }
  void _giveListHomeStandard(HomeInitial event, Emitter<HomeState> emit) async{
    DiscountRepository discountRepository = DiscountRepository();
    ParkingLotRepository parkingLotRepository = ParkingLotRepository();
    try{
      APIResult resultDiscount = await discountRepository.giveAllDiscountByPageAndSearch(0, event.token, '');
        int code_discount = resultDiscount.code;
        String message_discount  = resultDiscount.message;
      APIResult resultLot = await parkingLotRepository.giveParkingLotByPageAndSearch(0, event.token, '');
        int code_lot = resultLot.code;
        String message_lot = resultLot.message;

      if(code_lot == 200 && code_discount == 200){
        List<ParkingLot> lots = resultLot.result;
        List<Discount> discounts = resultDiscount.result;
        emit(HomeStandardState(lots, discounts));
      }
      else{
        emit(HomeErrorState("Please checking your connection $message_lot $message_discount"));
      }
    }
    catch(e){
      throw Exception("_giveListHomeStandard $e");
    }
  }
  void _gotoDetailLotScreen(GotoDetailLotEvent event,Emitter<HomeState> emit ) async{
    try{
      print("aaaaaaaaaaaaaaaa");
      ImageRepository imageRepository = ImageRepository();
      APIResult apiResult = await imageRepository.giveImageByParkingLot(event.token, event.parkingLot);
      if(apiResult.code ==200){
        print("................");
        List<Images> images = apiResult.result;
        emit(GotoDetailLotScreenState(images, event.parkingLot));
      }
      else {(emit(HomeErrorState(apiResult.message)));}
    }
    catch(e){
      Exception("HomeBloc__gotoDetailLotScreen $e");
    }

  }

}

