import 'package:myparkingapp/data/response/wallet__response.dart';

abstract class PaymentEvent {}

class GetPaymentEvent extends PaymentEvent{
  String orderInfo;
  double amount;
  WalletResponse wallet;
  GetPaymentEvent(this.orderInfo,this.amount,this.wallet);
}