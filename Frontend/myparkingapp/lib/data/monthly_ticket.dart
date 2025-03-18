import 'package:myparkingapp/data/parking_slots.dart';
import 'package:myparkingapp/data/user.dart';
import 'invoice.dart';

class MonthlyTicket {
  String monthlyTicketId;
  String slotId;
  String userId;
  String invoiceId;

  MonthlyTicket({
    required this.monthlyTicketId,
    required this.slotId,
    required this.userId,
    required this.invoiceId,
  });

  factory MonthlyTicket.fromJson(Map<String, dynamic> json) {
    return MonthlyTicket(
      monthlyTicketId: json['monthlyTicketId'],
      slotId: json['slotId'],
      userId: json['userId'],
      invoiceId: json['invoiceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monthlyTicketId': monthlyTicketId,
      'slotId': slotId,
      'userId': userId,
      'invoiceId': invoiceId,
    };
  }

  @override
  String toString() {
    return 'MonthlyTicket(monthlyTicketId: $monthlyTicketId, slotId: $slotId, userId: $userId, invoiceId: $invoiceId)';
  }
}
final MonthlyTicket monthlyTicketDemo = MonthlyTicket(
  monthlyTicketId: "MT001",
  slotId: "S011",
  userId: "U001",
  invoiceId: "INV001",
);
