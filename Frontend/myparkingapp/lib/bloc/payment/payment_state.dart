abstract class PaymentState {}

class PaymentInitialState extends PaymentState{

}
class PaymentLoadingState extends PaymentState{
  
}

class PaymentSuccessState extends PaymentState{
  String mess;
  PaymentSuccessState(this.mess);
}
class PaymentErrorState extends PaymentState{
  String mess;
  PaymentErrorState(this.mess);
}