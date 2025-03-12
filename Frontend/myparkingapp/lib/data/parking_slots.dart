enum SlotStatus {
  AVAILABLE, OCCUPIED, RESERVED
}
enum VehicleType {
  MOTORCYCLE,CAR, BICYCLE
}
class Slot {
  String slotId;
  String slotName;
  VehicleType vehicleType;
  SlotStatus slotStatus;
  double pricePerHour;
  double pricePerMonth;
  String lotId;
  String floorName;

  Slot({
    required this.slotId,
    required this.slotName,
    required this.vehicleType,
    required this.slotStatus,
    required this.pricePerHour,
    required this.pricePerMonth,
    required this.lotId,
    required this.floorName,
  });

  // Convert Slot to JSON
  Map<String, dynamic> toJson() => {
    'slotId': slotId,
    'slotName': slotName,
    'vehicleType': vehicleType.name, // enum -> string
    'slotStatus': slotStatus.name,   // enum -> string
    'pricePerHour': pricePerHour,
    'pricePerMonth': pricePerMonth,
    'lotId': lotId,
    'floorName':floorName
  };

  // Parse Slot from JSON
  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    slotId: json['slotId'],
    slotName: json['slotName'],
    vehicleType: VehicleType.values.firstWhere((e) => e.name == json['vehicleType']),
    slotStatus: SlotStatus.values.firstWhere((e) => e.name == json['slotStatus']),
    pricePerHour: (json['pricePerHour'] as num).toDouble(),
    pricePerMonth: (json['pricePerMonth'] as num).toDouble(),
    lotId: json['lotId'], floorName: json['floorName'],
  );

  @override
  String toString() {
    return 'Slot(slotId: $slotId, slotName: $slotName, vehicleType: $vehicleType, '
        'slotStatus: $slotStatus, pricePerHour: $pricePerHour, '
        'pricePerMonth: $pricePerMonth, lotId: $lotId)';
  }
}
List<Slot> demoSlots = [
  Slot(
    slotId: 'S001',
    slotName: 'Slot A1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', floorName: '1',
  ),
  Slot(
    slotId: 'S002',
    slotName: 'Slot A2',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001', floorName: '1',
  ),
  Slot(
    slotId: 'S003',
    slotName: 'Slot B1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 1.0,
    pricePerMonth: 20.0,
    lotId: 'PL001', floorName: '1',
  ),
  Slot(
    slotId: 'S004',
    slotName: 'Slot A1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', floorName: '1',
  ),
  Slot(
    slotId: 'S005',
    slotName: 'Slot A2',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001', floorName: '2',
  ),
  Slot(
    slotId: 'S006',
    slotName: 'Slot B1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 1.0,
    pricePerMonth: 20.0,
    lotId: 'PL001', floorName: '2',
  ),
];



