abstract class  CustomerParkingLotState{}

class  CustomerParkingLotInitial extends CustomerParkingLotState{

}

class  CustomerParkingLotLoadingState extends CustomerParkingLotState{

}

class  CustomerParkingLotLoadedState extends CustomerParkingLotState{

}

class  CustomerParkingLotErrorState extends CustomerParkingLotState{
  String mess;
  CustomerParkingLotErrorState(this.mess);
}

class  CustomerParkingLotSuccessState extends CustomerParkingLotState{
  String mess;
  CustomerParkingLotSuccessState(this.mess);


}