import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_slot/event.dart';
import 'package:myparkingappadmin/bloc/parking_slot/state.dart';

class  ParkingSlotBloc extends Bloc< ParkingSlotEvent, ParkingSlotState>{
   ParkingSlotBloc():super(ParkingSlotInitial()){
    
   }
}