// ignore_for_file: camel_case_types, file_names

import 'package:myparkingappadmin/models/parkingSlot.dart';

import '../../models/wallet.dart';
import '../../models/parkingLot.dart';
import '../../models/user.dart';

abstract class MainAppEvent{}

class initializationEvent extends MainAppEvent{
  final String token;
  initializationEvent(this.token);
}

class giveOwnerByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final int page;
  final String search;
  giveOwnerByPageAndSearchEvent(this.page, this.search, this.token);
}
class giveParkingLotByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final User owner;
  final int page;
  final String search;
  giveParkingLotByPageAndSearchEvent(this.owner, this.page, this.search, this.token);
}
class giveParkingSlotByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final ParkingLot parkingLot;
  final int page;
  final String search;
  giveParkingSlotByPageAndSearchEvent(this.parkingLot, this.page, this.search, this.token);
}
class giveInvoiceByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final ParkingSlot parkingSlot;
  final int page;
  final String search;
  giveInvoiceByPageAndSearchEvent(this.parkingSlot, this.page, this.search, this.token);
}
class giveDiscountByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final ParkingLot parkingLot;
  final int page;
  final String search;
  giveDiscountByPageAndSearchEvent(this.parkingLot, this.page, this.search, this.token);
}

class giveCustomerByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final int page;
  final String search;
  giveCustomerByPageAndSearchEvent(this.page, this.search, this.token);
}

class giveWalletByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final User customer;
  final int page;
  final String search;
  giveWalletByPageAndSearchEvent(this.customer,this.page,this.search, this.token);
}

class giveTransactionByPageAndSearchEvent extends MainAppEvent{
  final String token;
  final Wallet wallet;
  final int page;
  final String search;
  giveTransactionByPageAndSearchEvent(this.wallet,this.search,this.page, this.token);
}

class UpdateUserInfoEvent extends MainAppEvent{
  final User user;
  final String token;
  UpdateUserInfoEvent (this.user, this.token);
}

class UpdateStatusUserEvent  extends MainAppEvent{
  final String token;
  final bool newStatus;
  UpdateStatusUserEvent(this.newStatus, this.token);
}

class UpdateStatusParkingLotEvent extends MainAppEvent{
  final String token;
  final bool newStatus;
  UpdateStatusParkingLotEvent(this.newStatus, this.token);
}

class UpdateStatusParkingSlotEvent extends MainAppEvent{
  final String token;
  final bool newStatus;
  UpdateStatusParkingSlotEvent(this.newStatus, this.token);
}

class LogoutEvent extends MainAppEvent{
}


