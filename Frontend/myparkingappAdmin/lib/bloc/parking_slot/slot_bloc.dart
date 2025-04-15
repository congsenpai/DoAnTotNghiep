import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_event.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_state.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/parkingSlotRepository.dart';

class  ParkingSlotBloc extends Bloc< ParkingSlotEvent, ParkingSlotState>{
   ParkingSlotBloc():super(ParkingSlotInitial()){
    on<GetParkingSlotByLotIdEvent>(_getParkingSlotByLot);
    on<UpdateParkingSlotEvent>(_updateParkingSlot);

   }
   void _getParkingSlotByLot(GetParkingSlotByLotIdEvent event, Emitter<ParkingSlotState> emit) async{
     emit(ParkingSlotLoadingState());
     try{
      ParkingSlotRepository parkingSlotRepository = ParkingSlotRepository();

       final ApiResult apiResult = await parkingSlotRepository.getParkingSlotByLot(event.lotId.toString());
       if(apiResult.code == 200){

        List<ParkingSlotResponse> parkingSlotResponse = apiResult.result;
        Set<String> floorNames = parkingSlotResponse
        .map((slot) => slot.slotName.split('-').first)
        .toSet();
        List<SLotByFloor> slotsByFloor = [];
        for(var floorName in floorNames){
          List<ParkingSlotResponse> slotsOnFloor = parkingSlotResponse.where((slot) => slot.slotName.startsWith(floorName)).toList();
          SLotByFloor slotByFloor = SLotByFloor(floorName, floorNames.toList(), slotsOnFloor );
          slotsByFloor.add(slotByFloor);
       }
       emit(ParkingSlotLoadedState(slotsByFloor));
       }
       else{
         emit(ParkingSlotErrorState(apiResult.message));
       }
     }catch(e){
       emit(ParkingSlotErrorState(e.toString()));
     }
   }}
   void _updateParkingSlot(UpdateParkingSlotEvent event, Emitter<ParkingSlotState> emit) async{
     emit(ParkingSlotLoadingState());
     try{
      ParkingSlotRepository parkingSlotRepository = ParkingSlotRepository();

       final ApiResult result = await parkingSlotRepository.updateParkingSlot(event.parkingSlotId, event.request);
       if(result.code == 200){
         emit(ParkingSlotSuccessState(result.message));
       }else{
         emit(ParkingSlotErrorState(result.message));
       }
     }catch(e){
       emit(ParkingSlotErrorState(e.toString()));
     }
   }
