abstract class  ParkingSlotState{}

class  ParkingSlotInitial extends ParkingSlotState{

}

class  ParkingSlotLoadingState extends ParkingSlotState{

}

class  ParkingSlotLoadedState extends ParkingSlotState{

}

class  ParkingSlotErrorState extends ParkingSlotState{
  String mess;
  ParkingSlotErrorState(this.mess);
}

class  ParkingSlotSuccessState extends ParkingSlotState{
  String mess;
  ParkingSlotSuccessState(this.mess);


}