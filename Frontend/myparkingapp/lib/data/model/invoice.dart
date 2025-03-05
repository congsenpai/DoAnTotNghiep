// ignore_for_file: constant_identifier_names, camel_case_types

enum invoiceStatus {
  PENDING, PAID, CANCELLED
}

class Invoice {
  String userId;
  String invoiceId;
  double totalAmount;
  invoiceStatus status;
  String description;
  String parkingSlotId;
  String vehicle;
  String monthlyTicketId;
  DateTime updateAt;

  Invoice({
    required this.invoiceId,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.description,
    required this.parkingSlotId,
    required this.vehicle,
    required this.monthlyTicketId,
    required this.updateAt,
  });

  /// **Chuyển từ JSON sang `Invoice` object**
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json["invoiceId"] ?? '',
      totalAmount: (json["totalAmount"] ?? 0).toDouble(),
      status: json["status"] ?? '',
      description: json["description"] ?? '',
      parkingSlotId: json["parkingSlotId"] ?? '',
      vehicle: json["vehicle"] ?? '',
      monthlyTicketId: json["monthlyTicketId"] ?? '',
      updateAt: DateTime.parse(json["updateAt"] ?? DateTime.now().toIso8601String()), userId: json["userId"] ?? '',
    );
  }

  /// **Chuyển từ `Invoice` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "invoiceId": invoiceId,
      "totalAmount": totalAmount,
      "status": status,
      "description": description,
      "parkingSlotId": parkingSlotId,
      "vehicle": vehicle,
      "monthlyTicketId": monthlyTicketId,
      "updateAt": updateAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Invoice(invoiceId: $invoiceId, totalAmount: $totalAmount, status: $status)";
  }
}

List<Invoice> demoInvoices = [
  Invoice(
    invoiceId: 'INV001',
    totalAmount: 150.0,
    status: invoiceStatus.PAID,
    description: 'Parking fee for January',
    parkingSlotId: 'S001',
    vehicle: 'Car - ABC123',
    monthlyTicketId: 'MT001',
    updateAt: DateTime.now(), userId: 'U003',
  ),
  Invoice(
    invoiceId: 'INV002',
    totalAmount: 200.5,
    status: invoiceStatus.PAID,
    description: 'Monthly parking subscription',
    parkingSlotId: 'S002',
    vehicle: 'Bike - XYZ456',
    monthlyTicketId: 'MT002',
    updateAt: DateTime.now(), userId: 'U003',
  ),
];

