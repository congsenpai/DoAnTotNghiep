class MonthlyTicket {
  String monthlyTicketID;
  String parkingSlotID;
  String userID;
  String invoiceID;
  String createdAt;
  String updateAt;
  String expriedAt;

  MonthlyTicket({
    required this.monthlyTicketID,
    required this.parkingSlotID,
    required this.userID,
    required this.invoiceID,
    required this.createdAt,
    required this.updateAt,
    required this.expriedAt
  });

  factory MonthlyTicket.fromJson(Map<String, dynamic> json) {
    return MonthlyTicket(
      monthlyTicketID: json['monthlyTicketId'],
      userID: json['userId'],
      invoiceID: json['invoiceId'], parkingSlotID: json['parkingSlotID'], createdAt: '', updateAt: '', expriedAt: '',
    );
  }

  @override
  String toString() {
    return 'MonthlyTicket(monthlyTicketId: $monthlyTicketID, slotId: $parkingSlotID, userId: $userID, invoiceId: $invoiceID)';
  }
}
final MonthlyTicket monthlyTicketDemo = MonthlyTicket(
  monthlyTicketID: "MT001",
  userID: "U001",
  invoiceID: "INV001", parkingSlotID: '', createdAt: '', updateAt: '', expriedAt: '',
);
