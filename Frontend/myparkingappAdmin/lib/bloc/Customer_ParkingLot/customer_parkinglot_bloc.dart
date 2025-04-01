import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/customer_parkingLot/customer_parkinglot_event.dart';
import 'package:myparkingappadmin/bloc/customer_parkingLot/customer_parkinglot_state.dart';

class  CustomerParkingLotBloc extends Bloc< CustomerParkingLotEvent, CustomerParkingLotState>{
   CustomerParkingLotBloc():super(CustomerParkingLotInitial()){
    
   }
}