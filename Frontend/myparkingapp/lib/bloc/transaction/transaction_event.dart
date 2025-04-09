import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

abstract class TransactionEvent {}

class LoadTransactionEvent extends TransactionEvent{
  WalletResponse wallet;
  DateTime start;
  DateTime end;
  Transactions type;
  int page;
  LoadTransactionEvent(this.wallet, this.start,this.end, this.type, this.page);
}

class LoadAllTransactionEvent extends TransactionEvent{
  WalletResponse wallet;
  int page;
  LoadAllTransactionEvent(this.wallet, this.page);
}

class LoadAllTransactionByTimeEvent extends TransactionEvent{
  UserResponse userResponse;
  DateTime start;
  DateTime end;
  Transactions type;
  LoadAllTransactionByTimeEvent(this.userResponse, this.start, this.end, this.type);
}

class ExportExcellEvent extends TransactionEvent{

}

