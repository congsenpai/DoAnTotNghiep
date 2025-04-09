// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_event.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_state.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
// import 'package:myparkingapp/data/repository/slot_repository.dart';

class LotDetailBloc extends Bloc<LotDetailEvent,LotDetailState>{
  LotDetailBloc():super(LotDetailInitial()){
    on<LotDetailScreenInitialEvent>(_LoadHomeScreen);
    on<LoadListLotsEvent>(_LoadListLots);
  }

  Future<List<DataOnFloor>> loadDataOnFloor() async{
    List<ParkingSlotResponse> slots = demoSlots;
    Set<String> floorNames = demoSlots
        .map((slot) => slot.slotName.split('-').first)
        .toSet();
      List<DataOnFloor> datas = [];
      for(var name in floorNames){
        List<ParkingSlotResponse> slot = slots.where((i)=>i.slotName.contains(name)).toList();
        DataOnFloor dataOnFloor = DataOnFloor(name, slot, floorNames.toList());
        datas.add(dataOnFloor);
      }
      return datas;
  }
  void _LoadHomeScreen(LotDetailScreenInitialEvent event, Emitter<LotDetailState> emit) async {
    // SlotRepository slotRepository = SlotRepository();
    emit(LoadingLotDetailState());
    try {
      // ApiResult apiResult = await slotRepository.getParkingSlotList(event.parkingLot);
      // int code = apiResult.code;
      // String mess = apiResult.message;
      // if (code == 200) {
      //   DataOnFloor dataOnFloor = apiResult.result[0];
      //   emit(LoadedLotDetailState(dataOnFloor));
      // }
      // else {
      //   emit(LotDetailErrorScreen(mess));
      // }
      List<DataOnFloor> datas = await loadDataOnFloor();
      DataOnFloor dataOnFloor = datas[0];
      emit(LoadedLotDetailState(dataOnFloor));
      
    }
    catch (e) {
      Exception("LotDetailBloc : $e");
    }
  }
  void _LoadListLots(LoadListLotsEvent event, Emitter<LotDetailState> emit ) async{
    // SlotRepository slotRepository = SlotRepository();
    emit(LoadingLotDetailState());
    try {
      // ApiResult apiResult = await slotRepository.getParkingSlotList(
      //     event.token, event.parkingLot);
      // int code = apiResult.code;
      // String mess = apiResult.message;
      // if (code == 200) {
      //   List<DataOnFloor> datas = apiResult.result;
      //   DataOnFloor dataOnFloor = datas.firstWhere((data)=>data.floorName == event.floorName);
      //   emit(LoadedLotDetailState(dataOnFloor));
      // }
      // else {
      //   emit(LotDetailErrorScreen(mess));
      // }
      List<DataOnFloor> datas = await loadDataOnFloor();

      DataOnFloor dataOnFloor = datas.firstWhere((data)=>data.floorName == event.floorName);
      emit(LoadedLotDetailState(dataOnFloor));


    }
    catch (e) {
      Exception("LotDetailBloc : $e");
    }
  }
  }




