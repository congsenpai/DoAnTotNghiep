import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';

abstract class ParkingLotEvent{}


class GetParkingLotByOwnerEvent extends ParkingLotEvent{
  String userId;
  GetParkingLotByOwnerEvent(this.userId);
}

class UpdateStatusParkingLot extends ParkingLotEvent{
  String parkingLotId;
  LotStatus newStatus;
  UpdateStatusParkingLot(this.parkingLotId, this.newStatus);
}

class UpdateParkingLotEvent extends ParkingLotEvent{
  String parkingLotId;
  UpdateParkingLotRequest request;
  List<Images> deleteImage;
  List<Images> addImage;
  UpdateParkingLotEvent(this.parkingLotId, this.request, this.deleteImage, this.addImage);
}