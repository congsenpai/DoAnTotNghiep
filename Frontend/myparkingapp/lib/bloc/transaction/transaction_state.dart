import 'package:myparkingapp/data/response/transaction__response.dart';

abstract class TransactionState {}
class TransactionLoadedState extends TransactionState{
  List<TransactionResponse> trans;
  DateTime start;
  DateTime end;
  Transactions type;
  int page;
  int pageTotal;

  TransactionLoadedState(this.trans, this.start, this.end, this.type, this.page, this.pageTotal);

}

class TransactionLoadingState extends TransactionState{

}

class TransactionInitialState extends TransactionState{

}

class TransactionErrorState extends TransactionState{
  String mess;
  TransactionErrorState(this.mess);
}


