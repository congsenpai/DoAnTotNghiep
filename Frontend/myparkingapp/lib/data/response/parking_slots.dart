import 'package:myparkingapp/data/response/vehicle.dart';

enum SlotStatus {
  AVAILABLE, OCCUPIED, RESERVED
}
class ParkingSlot {
  String slotID;
  String slotName;
  VehicleType vehicleType;
  SlotStatus slotStatus;
  double pricePerHour;
  double pricePerMonth;
  String floorName;
  String lotId; // sau bỏ

  ParkingSlot({
    required this.slotID,
    required this.slotName,
    required this.vehicleType,
    required this.slotStatus,
    required this.pricePerHour,
    required this.pricePerMonth,
    required this.lotId,
    required this.floorName,
  });

  // Parse Slot from JSON
  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
    slotID: json['slotID'],
    slotName: json['slotName'],
    vehicleType: VehicleType.values.firstWhere((e) => e.name == json['vehicleType']),
    slotStatus: SlotStatus.values.firstWhere((e) => e.name == json['slotStatus']),
    pricePerHour: (json['pricePerHour'] as num).toDouble(),
    pricePerMonth: (json['pricePerMonth'] as num).toDouble(),
    lotId: "",
    floorName: json['floorName'],
  );

  @override
  String toString() {
    return 'Slot(slotId: $slotID, slotName: $slotName, vehicleType: $vehicleType, '
        'slotStatus: $slotStatus, pricePerHour: $pricePerHour, '
        'pricePerMonth: $pricePerMonth, lotId: $lotId)';
  }
}
List<ParkingSlot> demoSlots = [
  ParkingSlot(
    slotID: 'S001',
    slotName: 'Slot A1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.RESERVED,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', floorName: '1',
  ),
  ParkingSlot(
    slotID: 'S002',
    slotName: 'Slot A2',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.OCCUPIED,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001', floorName: '1',
  ),
  ParkingSlot(
    slotID: 'S003',
    slotName: 'Slot B1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 1.0,
    pricePerMonth: 20.0,
    lotId: 'PL001', floorName: '1',
  ),
  ParkingSlot(
    slotID: 'S004',
    slotName: 'Slot A1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', floorName: '1',
  ),
  ParkingSlot(slotID: 'S011',
    slotName: 'Slot A1',
    vehicleType: VehicleType.CAR,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', floorName: '1',
  ),
  ParkingSlot(
    slotID: 'S012',
    slotName: 'Slot A2',
    vehicleType: VehicleType.CAR,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001', floorName: '1',
  ),
  ParkingSlot(
    slotID: 'S005',
    slotName: 'Slot A2',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001', floorName: '2',
  ),
  ParkingSlot(
    slotID: 'S006',
    slotName: 'Slot B1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 1.0,
    pricePerMonth: 20.0,
    lotId: 'PL001', floorName: '2',
  ),
];


class DataOnFloor{
  final String floorName;
  final List<ParkingSlot> lots;
  final List<String> floorNames;

  DataOnFloor(
    this.floorName,this.lots, this.floorNames
    );
}

