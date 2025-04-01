// ignore_for_file: file_names, camel_case_types, duplicate_ignore
import 'package:myparkingappadmin/dto/response/discount.dart';
import 'package:myparkingappadmin/dto/response/parkingSlot.dart';

import '../../dto/response/invoice.dart';
import '../../dto/response/wallet.dart';
import '../../dto/response/parkingLot.dart';
import '../../dto/response/transaction.dart';
import '../../dto/response/user.dart';

abstract class MainAppState{}

class MainInitial extends MainAppState{}

class GiveUserListsState extends MainAppState {
  final List<User> customers;
  final List<User> owners;

  GiveUserListsState(this.customers, this.owners);
}


class giveOwnerListState extends MainAppState{
  final List<User> owner;
  giveOwnerListState(this.owner);
}
class giveParkingLotListState extends MainAppState{
  final List<ParkingLot> parkingLots;
  giveParkingLotListState(this.parkingLots);
}
class giveParkingSlotListState extends MainAppState{
  final List<ParkingSlot> parkingSlots;
  giveParkingSlotListState(this.parkingSlots);
}
class giveInvoiceListState extends MainAppState{
  final List<Invoice> invoices;
  giveInvoiceListState(this.invoices);
}
class giveDiscountListState extends MainAppState{
  final List<Discount> discounts;
  giveDiscountListState(this.discounts);
}


class giveCustomerListState extends MainAppState{
  final List<User> customer;
  giveCustomerListState(this.customer);
}

// ignore: camel_case_types
class giveWalletListState extends MainAppState{
  final List<Wallet> wallets;
  giveWalletListState(this.wallets);
}

class giveTransactionState extends MainAppState{
  final List<Transaction> trans;
  giveTransactionState(this.trans);
}


class UpdateUserSuccessState extends MainAppState{
  final User user;
  UpdateUserSuccessState(this.user);
}

class LogoutSuccess extends MainAppState{
}

class MainAppErrorState extends MainAppState{
  final String error;
  MainAppErrorState(this.error);
}
