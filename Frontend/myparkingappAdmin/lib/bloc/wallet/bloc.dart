import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/Wallet/event.dart';
import 'package:myparkingappadmin/bloc/Wallet/state.dart';

class  WalletBloc extends Bloc< WalletEvent, WalletState>{
   WalletBloc():super(WalletInitial()){
    
   }
}