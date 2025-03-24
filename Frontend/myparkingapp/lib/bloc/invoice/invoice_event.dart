import 'package:myparkingapp/data/response/invoice.dart';

import '../../data/response/user.dart';

abstract class InvoiceEvent{}

class InvoiceInitialEvent extends InvoiceEvent{
  final User user;
  final String search;
  final int page;
  InvoiceInitialEvent(this.user, this.search, this.page);
}