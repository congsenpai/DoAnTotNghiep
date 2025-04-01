abstract class  InvoiceState{}

class  InvoiceInitial extends InvoiceState{

}

class  InvoiceLoadingState extends InvoiceState{

}

class  InvoiceLoadedState extends InvoiceState{

}

class  InvoiceErrorState extends InvoiceState{
  String mess;
  InvoiceErrorState(this.mess);
}

class  InvoiceSuccessState extends InvoiceState{
  String mess;
  InvoiceSuccessState(this.mess);


}