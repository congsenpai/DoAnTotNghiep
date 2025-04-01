import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/Discount/event.dart';
import 'package:myparkingappadmin/bloc/Discount/state.dart';

class  DiscountBloc extends Bloc< DiscountEvent, DiscountState>{
   DiscountBloc():super(DiscountInitial()){
    
   }
}