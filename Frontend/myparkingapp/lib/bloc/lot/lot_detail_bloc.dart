import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_event.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/data_on_floor.dart';
import 'package:myparkingapp/repository/lots_repository.dart';
import 'package:myparkingapp/repository/slot_repository.dart';

class LotDetailBloc extends Bloc<LotDetailEvent,LotDetailState>{
  LotDetailBloc():super(LotDetailInitial()){
    on<LotDetailScreenInitialEvent>(_LoadHomeScreen);
    on<LoadListLotsEvent>(_LoadListLots);
  }
  void _LoadHomeScreen(LotDetailScreenInitialEvent event, Emitter<LotDetailState> emit) async {
    SlotRepository slotRepository = SlotRepository();
    emit(LoadingLotDetailState());
    try {
      ApiResult apiResult = await slotRepository.getParkingSlotList(
          event.token, event.parkingLot);
      int code = apiResult.code;
      String mess = apiResult.message;
      if (code == 200) {
        DataOnFloor dataOnFloor = apiResult.result[0];
        emit(LoadedLotDetailState(dataOnFloor));
      }
      else {
        emit(LotDetailErrorScreen(mess));
      }
    }
    catch (e) {
      Exception("LotDetailBloc : $e");
    }
  }
  void _LoadListLots(LoadListLotsEvent event, Emitter<LotDetailState> emit ) async{
    SlotRepository slotRepository = SlotRepository();
    emit(LoadingLotDetailState());
    try {
      ApiResult apiResult = await slotRepository.getParkingSlotList(
          event.token, event.parkingLot);
      int code = apiResult.code;
      String mess = apiResult.message;
      if (code == 200) {
        List<DataOnFloor> datas = apiResult.result;
        DataOnFloor dataOnFloor = datas.firstWhere((data)=>data.floorName == event.floorName);
        emit(LoadedLotDetailState(dataOnFloor));
      }
      else {
        emit(LotDetailErrorScreen(mess));
      }
    }
    catch (e) {
      Exception("LotDetailBloc : $e");
    }
  }
  }




