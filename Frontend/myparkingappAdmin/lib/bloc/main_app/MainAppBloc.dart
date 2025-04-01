// ignore_for_file: avoid_print, file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/dto/response/parkingLot.dart';
import 'package:myparkingappadmin/dto/response/transaction.dart';
import 'package:myparkingappadmin/dto/response/wallet.dart';
import 'package:myparkingappadmin/repository/parkingLotRepository.dart';
import 'package:myparkingappadmin/repository/transactionRepository.dart';
import 'package:myparkingappadmin/repository/userRepository.dart';
import '../../apiResponse.dart';
import '../../dto/response/discount.dart';
import '../../dto/response/invoice.dart';
import '../../dto/response/parkingSlot.dart';
import '../../dto/response/user.dart';
import '../../repository/authRepository.dart';
import '../../repository/discountRepository.dart';
import '../../repository/invoiceRepository.dart';
import '../../repository/parkingSlotRepository.dart';
import '../../repository/walletRepository.dart';
import 'MainAppEvent.dart';
import 'MainAppState.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  MainAppBloc() : super(MainInitial()) {
    on<initializationEvent>(_initialList);
    on<giveOwnerByPageAndSearchEvent>(_giveOwnerList);
    on<giveCustomerByPageAndSearchEvent>(_giveCustomerList);

    on<UpdateUserInfoEvent>(_updatedUserInfo);
    on<LogoutEvent>(_logout);
    on<giveParkingLotByPageAndSearchEvent>(_giveParkingLotByPageAndSearch);
    on<giveParkingSlotByPageAndSearchEvent>(_giveParkingSlotByPageAndSearch);
    on<giveInvoiceByPageAndSearchEvent>(_giveInvoiceByPageAndSearch);
    on<giveDiscountByPageAndSearchEvent>(_giveDiscountByPageAndSearch);
    on<giveWalletByPageAndSearchEvent>(_giveWalletByPageAndSearch);
    on<giveTransactionByPageAndSearchEvent>(_giveTransactionByPageAndSearch);
  }
  void _initialList(initializationEvent event, Emitter<MainAppState> emit) async {
    UserRepository userRepository = UserRepository();
    try {
      APIResult userResult = await userRepository.giveAllUserByPage_BySearch_ByCUSTOMER_ROLE(0, event.token, 'ROLE_CUSTOMER', '');
      APIResult ownerResult = await userRepository.giveAllUserByPage_BySearch_ByOWNER_ROLE(0, event.token, 'ROLE_OWNER', '');

      if (userResult.code == 200 && ownerResult.code == 200) {
        emit(GiveUserListsState(userResult.result, ownerResult.result));
      } else {
        emit(MainAppErrorState("Failed to load users"));
      }
    } catch (e) {
      emit(MainAppErrorState("Cannot fetch user lists"));
    }
  }
  void _giveOwnerList(giveOwnerByPageAndSearchEvent event, Emitter<MainAppState> emit) async {
    UserRepository userRepository = UserRepository();
    try {
      APIResult userResult = await userRepository.giveAllUserByPage_BySearch_ByOWNER_ROLE(0,event.token,'ROLE_OWNER',event.search);
      List<User> customer = [];
      customer=userResult.result;
      String message = userResult.message;
      int code = userResult.code;
      if(code == 200){
        emit(giveOwnerListState(customer)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      }
    } catch (e) {
      emit(MainAppErrorState("Cannot give owner list")); // Ensure an exception is thrown
    }
  }
  void _giveCustomerList(giveCustomerByPageAndSearchEvent event, Emitter<MainAppState> emit) async {
    UserRepository userRepository = UserRepository();
    try {
      APIResult userResult = await userRepository.giveAllUserByPage_BySearch_ByCUSTOMER_ROLE(0,event.token,'ROLE_OWNER',event.search);
      List<User> customer = userResult.result;
      String message = userResult.message;
      int code = userResult.code;
      if(code == 200){
        emit(giveCustomerListState(customer)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      }
    } catch (e) {
      emit(MainAppErrorState("Cannot give owner list")); // Ensure an exception is thrown
    }
  }

  void _giveParkingLotByPageAndSearch(giveParkingLotByPageAndSearchEvent event, Emitter<MainAppState> emit) async {
    ParkingLotRepository parkingLotRepository = ParkingLotRepository();
    try {
      APIResult parkingLotResult = await parkingLotRepository.giveParkingLotByPageAndSearch(event.page, event.token, event.owner, event.search);
      List<ParkingLot> parkingLots = parkingLotResult.result;
      String message = parkingLotResult.message;
      int code = parkingLotResult.code;
      if(code == 200){
        emit(giveParkingLotListState(parkingLots)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      } // Ensure a value is returned
    } catch (e) {
      emit(MainAppErrorState("Cannot give parkingLot list")); // Ensure an exception is thrown
    }
  }
  void _giveParkingSlotByPageAndSearch(giveParkingSlotByPageAndSearchEvent event, Emitter<MainAppState> emit) async {
    ParkingSlotRepository slotRepository = ParkingSlotRepository();
    try {
      APIResult slotResult = await slotRepository.giveParkingLotByPageAndSearch(event.page, event.token, event.parkingLot, event.search);
      List<ParkingSlot> parkingSlots = slotResult.result;
      String message = slotResult.message;
      int code = slotResult.code;
      if(code == 200){
        emit(giveParkingSlotListState(parkingSlots)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      } // Ensure a value is returned
    } catch (e) {
      emit(MainAppErrorState("Cannot give parkingSlots list")); // Ensure an exception is thrown
    }
  }
  void _giveInvoiceByPageAndSearch(giveInvoiceByPageAndSearchEvent event, Emitter<MainAppState> emit) async {
    InvoiceRepository invoiceRepository = InvoiceRepository();
    try {
      APIResult slotResult = await invoiceRepository.giveInvoiceByPageAndSearch(event.page, event.token, event.parkingSlot, event.search);
      List<Invoice> invoices = slotResult.result;
      String message = slotResult.message;
      int code = slotResult.code;
      if(code == 200){
        emit(giveInvoiceListState(invoices)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      } // Ensure a value is returned
    } catch (e) {
      emit(MainAppErrorState("Cannot give invoices list")); // Ensure an exception is thrown
    }
  }
  void _giveDiscountByPageAndSearch(giveDiscountByPageAndSearchEvent event, Emitter<MainAppState> emit) async {
    DiscountRepository discountRepository = DiscountRepository();
    try {
      APIResult discountResult = await discountRepository.giveDiscountByPageAndSearch(event.page, event.token, event.parkingLot, event.search);
      List<Discount> discountSlots = discountResult.result;
      String message = discountResult.message;
      int code = discountResult.code;
      if(code == 200){
        emit(giveDiscountListState(discountSlots)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      } // Ensure a value is returned
    } catch (e) {
      emit(MainAppErrorState("Cannot give parkingSlots list")); // Ensure an exception is thrown
    }
  }
  void _giveWalletByPageAndSearch(giveWalletByPageAndSearchEvent event,Emitter<MainAppState> emit) async{
    WalletRepository walletRepository = WalletRepository();
    try {
      APIResult walletResult = await walletRepository.giveWalletByPageAndSearch(event.page, event.token, event.customer, event.search);
      List<Wallet> wallets = walletResult.result;
      String message = walletResult.message;
      int code = walletResult.code;
      if(code == 200){
        emit(giveWalletListState(wallets)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      } // Ensure a value is returned
    } catch (e) {
      emit(MainAppErrorState("Cannot give parkingSlots list")); // Ensure an exception is thrown
    }
  }
  void _giveTransactionByPageAndSearch(giveTransactionByPageAndSearchEvent event,Emitter<MainAppState> emit) async{
    TransactionRepository transactionRepository = TransactionRepository();
    try {
      APIResult transResult = await transactionRepository.giveTransactionByPageAndSearch(event.page, event.token, event.wallet, event.search);
      List<Transaction> trans = transResult.result;
      String message = transResult.message;
      int code = transResult.code;
      if(code == 200){
        emit(giveTransactionState(trans)); // Ensure a value is returned
      }
      else{
        emit(MainAppErrorState(message));
      } // Ensure a value is returned
    } catch (e) {
      emit(MainAppErrorState("Cannot give parkingSlots list")); // Ensure an exception is thrown
    }
  }

  void _updatedUserInfo(UpdateUserInfoEvent event, Emitter<MainAppState> emit) async{
    try {
      User user = event.user;
      final UserRepository userRepository = UserRepository();
      APIResult userResult = await userRepository.updatedUser(user,event.token);
      user = userResult.result;
      String message = userResult.message;
      int code = userResult.code;
      if(code == 200){
        emit(
            UpdateUserSuccessState(user)
        );
      }
      else{
        emit(MainAppErrorState(message));
      }

    }
    catch(e){
      print("_updatedUserInfo $e");
    }
  }
  void _logout(LogoutEvent event, Emitter<MainAppState> emit) async{
    final AuthRepository userRepository = AuthRepository();
    userRepository.logout();
    emit(
      LogoutSuccess()
    );
  }
} 


