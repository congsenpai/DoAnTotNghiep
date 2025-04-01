abstract class  TransactionState{}

class  TransactionInitial extends TransactionState{

}

class  TransactionLoadingState extends TransactionState{

}

class  TransactionLoadedState extends TransactionState{

}

class  TransactionErrorState extends TransactionState{
  String mess;
  TransactionErrorState(this.mess);
}

class  TransactionSuccessState extends TransactionState{
  String mess;
  TransactionSuccessState(this.mess);


}