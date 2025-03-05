// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/data/response/Slot/ListSlot.dart';
import 'package:myparkingapp/data/response/apiResponse.dart';
import 'package:myparkingapp/repository/parkingSlotRepository.dart';


import '../../data/model/parkingSlot.dart';
import '../../data/model/vehicle.dart';
import 'LotEvent.dart';
import 'LotState.dart';

class LotBloc extends Bloc<LotEvent,LotState>{
  LotBloc():super(LotInitialState()){
    on<GotoSlotScreenEvent>(_giveSlotList);
    on<ChangeImageEvent>(_changerImage);
  }
  void _giveSlotList(GotoSlotScreenEvent event, Emitter<LotState> emit) async{
    ParkingSlotRepository parkingSlotRepository = ParkingSlotRepository();
    try{
      APIResult apiResult = await parkingSlotRepository.giveParkingLotByPageAndSearch(0,event.token, event.parkingLot);
      List<ParkingSlot> slots = apiResult.result;
      Set<String> floors = slots.map((slot) => slot.floorName).toSet();
      List<FloorOfLot> floorOfLots = [];
      for (var floor in floors){
        List<ParkingSlot> cars = slots.where((slot)=>slot.vehicleType == VehicleType.CAR && slot.floorName == floor).toList();
        List<ParkingSlot> motos = slots.where((slot)=>slot.vehicleType == VehicleType.MOTORCYCLE && slot.floorName == floor).toList();
        ListSlot listSlot = ListSlot(cars, motos);
        FloorOfLot floorOfLot = FloorOfLot(floor, listSlot);
        floorOfLots.add(floorOfLot);
      }
      emit(GotoSlotScreenState(event.token, floorOfLots));
    }
    catch(e){
    throw Exception("LotBloc__giveSlotList:  $e");
    }
  }
  void _changerImage(ChangeImageEvent event, Emitter<LotState> emit){
    emit(LotLoadedState(event.image));
    
}

}