import 'package:myparkingapp/data/response/invoice_response.dart';

import '../../data/response/user__response.dart';

abstract class InvoiceEvent{}

class InvoiceInitialEvent extends InvoiceEvent{
  final UserResponse user;
  final String search;
  final int page;
  InvoiceInitialEvent(this.user, this.search, this.page);
}