abstract class  DiscountState{}

class  DiscountInitial extends DiscountState{

}

class  DiscountLoadingState extends DiscountState{

}

class  DiscountLoadedState extends DiscountState{

}

class  DiscountErrorState extends DiscountState{
  String mess;
  DiscountErrorState(this.mess);
}

class  DiscountSuccessState extends DiscountState{
  String mess;
  DiscountSuccessState(this.mess);


}