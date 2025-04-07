import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_event.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_state.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/parkingLotRepository.dart';


class  ParkingLotBloc extends Bloc< ParkingLotEvent, ParkingLotState>{
   ParkingLotBloc():super(ParkingLotInitial()){
      on<GetParkingLotByOwnerEvent>(_getParkingLotByOwner);
      on<UpdateStatusParkingLot>(_updateStatusParkingLot);
      on<UpdateParkingLotEvent>(_updateParkingLot);
   }
   void _getParkingLotByOwner(GetParkingLotByOwnerEvent event, Emitter<ParkingLotState> emit) async{
    //  try{
    //    emit(ParkingLotLoadingState());
    //    ParkingLotRepository parkingLotRepository = ParkingLotRepository();
    //    // Call repository method to get parking lot by owner
    //    final response = await parkingLotRepository.getParkingLotByOwner(event.userId);
    //    if(response.code == 200){
    //      emit(ParkingLotLoadedState(response.result));
    //    }else{
    //      emit(ParkingLotErrorState(response.message));
    //    }
    //  }catch(e){
    //    emit(ParkingLotErrorState(e.toString()));
    //  }
    emit(ParkingLotLoadedState(parkingLots));
   }
   void _updateStatusParkingLot(UpdateStatusParkingLot event, Emitter<ParkingLotState> emit) async{
     try{
       emit(ParkingLotLoadingState());
       ParkingLotRepository parkingLotRepository = ParkingLotRepository();
       final response = await parkingLotRepository.updateStatusParkingLot(event.newStatus, event.parkingLotId);
       if(response.code == 200){
         emit(ParkingLotSuccessState(response.message));
       }else{
         emit(ParkingLotErrorState(response.message));
       }
     }catch(e){
       emit(ParkingLotErrorState(e.toString()));
     }
   }
    void _updateParkingLot(UpdateParkingLotEvent event, Emitter<ParkingLotState> emit) async{
      try{
        emit(ParkingLotLoadingState());
        ParkingLotRepository parkingLotRepository = ParkingLotRepository();
        final response = await parkingLotRepository.updateParkingLot(event.parkingLotId, event.request);
        if(response.code == 200){
          emit(ParkingLotSuccessState(response.message));
        }else{
          emit(ParkingLotErrorState(response.message));
        }
      }catch(e){
        emit(ParkingLotErrorState(e.toString()));
      }
    }
}