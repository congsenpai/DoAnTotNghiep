// ignore_for_file: unused_import, avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/MainApp/MainAppBloc.dart';
import 'package:myparkingappadmin/bloc/MainApp/MainAppEvent.dart';
import 'package:myparkingappadmin/bloc/MainApp/MainAppState.dart';
import 'package:myparkingappadmin/models/invoice.dart';
import 'package:myparkingappadmin/models/parkingLot.dart';
import 'package:myparkingappadmin/screens/myprofile/myprofile_screen.dart';
import 'package:myparkingappadmin/models/transaction.dart';
import '../../controllers/menu_app_controller.dart';
import '../../models/discount.dart';
import '../../models/parkingSlot.dart';
import '../../models/wallet.dart';
import '../../models/user.dart';
import '../authentication/register_screen.dart';
import '../authentication/login_screen.dart';
import '../customer/customerScreen.dart';
import '../dashboard/dashboard_screen.dart';
import '../owner/owner_screen.dart';
import '../setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'components/side_menu.dart';
import '../../responsive.dart';

class MainScreen extends StatefulWidget {
  final String token;
  final bool isAuth;
  final User user;
  final Function(Locale) onLanguageChange;
  const MainScreen({super.key,
    required this.isAuth, required this.user, required this.onLanguageChange, required this.token
});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late User selectedUsersLogin;
  int _currentTab = 1;
  List<User> owners = [];
  List<ParkingLot> parkingLots = [];
  List<ParkingSlot> parkingSlots = [];
  List<Invoice> invoices = [];
  List<Discount> discounts = [];

  List<User> customer = [];
  List<Wallet> wallet = [];
  List<Transaction> trans =[];
  @override
  void initState() {
    super.initState();
    selectedUsersLogin = widget.user;
    context.read<MainAppBloc>()
        .add(initializationEvent(widget.token));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(onMenuTap: (int index) {
        setState(() {
          _currentTab = index;
        });
      }, isAuth: widget.isAuth,),
      body: BlocConsumer<MainAppBloc,MainAppState>(
        builder: (context,state){
          if(state is giveCustomerListState){
            customer = state.customer;
            print("customer ${customer.length}");
          }
          else if(state is GiveUserListsState){
            customer = state.customers;
            owners = state.owners;
          }
          else if(state is giveWalletListState){
            wallet = state.wallets;
            print("wallet $wallet");
          }
          else if(state is giveTransactionState){
            trans = state.trans;
            print("trans $trans");
          }
          else if(state is giveOwnerListState){
            owners = state.owner;
            print("owner: ${owners.length}");
          }
          else if(state is giveParkingLotListState){
            parkingLots = state.parkingLots;
            print("parkingLot: $parkingLots");
          }
          else if(state is giveParkingSlotListState){
            parkingSlots = state.parkingSlots;
            print("Slots: $parkingSlots");
          }
          else if(state is giveInvoiceListState){
            invoices = state.invoices;
            print("Invoice: $invoices");
          }
          else if(state is giveDiscountListState){
            discounts = state.discounts;
            print("Discount: $discounts");
          }
          else if(state is UpdateUserSuccessState){
            selectedUsersLogin = state.user;
          }
        return SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(child: SideMenu(onMenuTap: (int index) {
                setState(() {
                  _currentTab = index;
                });
              }, isAuth: widget.isAuth,)),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 8,
              child: _getScreen(_currentTab),
            ),
          ],
        ),
      );
      }, listener: (context,state){
        if(state is MainAppErrorState){
          print(state.error);
        }
        else if(state is LogoutSuccess){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(isAuth: false, onLanguageChange: widget.onLanguageChange, ),
              ),
            );
        }
      })
    );
  }
  Widget _getScreen(int tab) {
    switch (tab) {
      case 1:
        return DashboardScreen(isAuth: widget.isAuth, user: selectedUsersLogin, onLanguageChange: widget.onLanguageChange);
      case 2:
        return OwnerScreen(
          isAuth: widget.isAuth,
          user: selectedUsersLogin,
          owner: owners,
          onLanguageChange: widget.onLanguageChange,
          token: widget.token,
          parkingLots: parkingLots,
          parkingSlots: parkingSlots,
          invoices: invoices,
          discount: discounts,
        );
      case 3:
        return CustomerScreen(
          isAuth: widget.isAuth,
          user: selectedUsersLogin,
          customer: customer,
          onLanguageChange: widget.onLanguageChange,
          token: widget.token, trans: trans, wallet: wallet,
        );
      case 4:
        return MyprofileScreen(
          isAuth: widget.isAuth,
          user: selectedUsersLogin,
          onLanguageChange: widget.onLanguageChange,
          token: widget.token,
        );
      default:
        return DashboardScreen(
          isAuth: widget.isAuth,
          user: selectedUsersLogin,
          onLanguageChange: widget.onLanguageChange,
        );
    }
  }
}

