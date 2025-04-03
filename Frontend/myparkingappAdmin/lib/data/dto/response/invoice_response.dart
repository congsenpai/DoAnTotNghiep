class InvoiceResponse {
  String invoiceId;
  double totalAmount;
  String status;
  String description;
  String parkingSlotId;
  String vehicle;
  String monthlyTicketId;
  DateTime updateAt;

  InvoiceResponse({
    required this.invoiceId,
    required this.totalAmount,
    required this.status,
    required this.description,
    required this.parkingSlotId,
    required this.vehicle,
    required this.monthlyTicketId,
    required this.updateAt,
  });

  /// **Chuyển từ JSON sang `Invoice` object**
  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      invoiceId: json["invoiceId"] ?? '',
      totalAmount: (json["totalAmount"] ?? 0).toDouble(),
      status: json["status"] ?? '',
      description: json["description"] ?? '',
      parkingSlotId: json["parkingSlotId"] ?? '',
      vehicle: json["vehicle"] ?? '',
      monthlyTicketId: json["monthlyTicketId"] ?? '',
      updateAt: DateTime.parse(json["updateAt"] ?? DateTime.now().toIso8601String()),
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

List<InvoiceResponse> demoInvoices = [
  InvoiceResponse(
    invoiceId: 'INV001',
    totalAmount: 150.0,
    status: 'Paid',
    description: 'Parking fee for January',
    parkingSlotId: 'S001',
    vehicle: 'Car - ABC123',
    monthlyTicketId: 'MT001',
    updateAt: DateTime.now(),
  ),
  InvoiceResponse(
    invoiceId: 'INV002',
    totalAmount: 200.5,
    status: 'Pending',
    description: 'Monthly parking subscription',
    parkingSlotId: 'S002',
    vehicle: 'Bike - XYZ456',
    monthlyTicketId: 'MT002',
    updateAt: DateTime.now(),
  ),
];

