import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/Customer_Wallet/customer_wallet_state.dart';
import 'package:myparkingappadmin/bloc/customer_wallet/customer_wallet_event.dart';

class  CustomerWalletBloc extends Bloc< CustomerWalletEvent, CustomerWalletState>{
   CustomerWalletBloc():super(CustomerWalletInitial()){
    
   }
}