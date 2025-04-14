abstract class TransactionEvent{}


class GetTransactionsByWalletEvent extends TransactionEvent{
  String parkingLotID;
  GetTransactionsByWalletEvent(this.parkingLotID);
}