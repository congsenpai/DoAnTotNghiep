// ignore_for_file: file_names, camel_case_types, duplicate_ignore
import 'package:myparkingappadmin/dto/response/discount_response.dart';
import 'package:myparkingappadmin/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/dto/response/user_response.dart';

import '../../dto/response/invoice_response.dart';
import '../../dto/response/wallet_response.dart';
import '../../dto/response/parkingLot_response.dart';
import '../../dto/response/transaction_response.dart';


abstract class MainAppState{}

class MainInitial extends MainAppState{}

class GiveUserListsState extends MainAppState {
  final List<UserResponse> customers;
  final List<UserResponse> owners;

  GiveUserListsState(this.customers, this.owners);
}


class giveOwnerListState extends MainAppState{
  final List<UserResponse> owner;
  giveOwnerListState(this.owner);
}
class giveParkingLotListState extends MainAppState{
  final List<ParkingLotResponse> parkingLots;
  giveParkingLotListState(this.parkingLots);
}
class giveParkingSlotListState extends MainAppState{
  final List<ParkingSlotResponse> parkingSlots;
  giveParkingSlotListState(this.parkingSlots);
}
class giveInvoiceListState extends MainAppState{
  final List<InvoiceResponse> invoices;
  giveInvoiceListState(this.invoices);
}
class giveDiscountListState extends MainAppState{
  final List<Discount_Response> discounts;
  giveDiscountListState(this.discounts);
}


class giveCustomerListState extends MainAppState{
  final List<UserResponse> customer;
  giveCustomerListState(this.customer);
}

// ignore: camel_case_types
class giveWalletListState extends MainAppState{
  final List<Wallet> wallets;
  giveWalletListState(this.wallets);
}

class giveTransactionState extends MainAppState{
  final List<TransactionResponse> trans;
  giveTransactionState(this.trans);
}


class UpdateUserSuccessState extends MainAppState{
  final UserResponse user;
  UpdateUserSuccessState(this.user);
}

class LogoutSuccess extends MainAppState{
}

class MainAppErrorState extends MainAppState{
  final String error;
  MainAppErrorState(this.error);
}
