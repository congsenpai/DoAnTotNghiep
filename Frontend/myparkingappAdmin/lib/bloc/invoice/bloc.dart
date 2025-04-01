import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/invoice/event.dart';
import 'package:myparkingappadmin/bloc/invoice/state.dart';

class  InvoiceBloc extends Bloc< InvoiceEvent, InvoiceState>{
   InvoiceBloc():super(InvoiceInitial()){
    
   }
}