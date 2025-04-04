
// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, file_names

import 'dart:collection';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/bloc/Customer_Wallet/customer_wallet_bloc.dart';
import 'package:myparkingappadmin/bloc/Customer_Wallet/customer_wallet_event.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';
import '../../constants.dart';
import '../../responsive.dart';
import '../general/header.dart';
import '../main/components/classInitial.dart';
import '../transaction/components/transaction_list.dart';
import '../wallet/WalletList.dart';
import 'components/customer_list.dart';


class CustomerScreen extends StatefulWidget {

  final bool isAuth;
  final UserResponse user;
  final Function(Locale) onLanguageChange;
  const CustomerScreen({
    super.key, 
    required this.isAuth,
    required this.user,  
    required this.onLanguageChange});

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final HashSet<String> objectColumnNameOfWallet = HashSet.from([
    "WalletName",
    "Type Money",
    "Detail",
    "TranList"
  ]);
  final HashSet<String> objectColumnNameOfTransaction = HashSet.from([
    "TranId",
    "Date",
    "Amount",
    "Detail",
  ]);
  UserResponse selectedUser = selectedUserInitial;
  WalletResponse selectedWallet = selectedWalletInitial;
  TransactionResponse selectedTransaction = selectedTransactionInitial;
  bool SelectWalletList = false;
  bool SelectTranList = false;

  List<UserResponse> customer = [];

  @override
  void initState() {
    super.initState();
    context.read<CustomerWalletBloc>().add(CWLoadingScreenEvent(token, page, search));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: AppLocalizations.of(context).translate("Customer"),
            user: widget.user,
            isAuth: widget.isAuth, onLanguageChange: widget.onLanguageChange),
            SizedBox(height: defaultPadding),
            Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex : 1,
                                child: Column(
                                  children: [
                                    CustomerList(
                                          onCustomer_Wallet: updateCustomer_Wallet, token: widget.token,
                                        ),
                                  ],
                                ),
                              ),
                              if(Responsive.isDesktop(context) && SelectWalletList)
                                SizedBox(width: defaultPadding),
                              if(Responsive.isDesktop(context) && SelectWalletList)
                                Expanded(
                                  flex: 1,
                                    child: WalletList(
                                        object: widget.wallet,
                                        objectColumnName: objectColumnNameOfWallet,
                                        title: "walletList",
                                        onWallet_Tran: updateWallet_Transaction,
                                        customer: selectedUser,
                                        token: widget.token)),
                              if(Responsive.isDesktop(context) && SelectTranList)
                                SizedBox(width: defaultPadding),
                              if(Responsive.isDesktop(context) && SelectTranList)
                                Expanded(child: TransactionList(
                                    object: widget.trans,
                                    objectColumnName: objectColumnNameOfTransaction,
                                    title: "transactionList",
                                    wallet: selectedWallet,
                                    currentPage: true)
                                )

                            ],

                          ),
                          SizedBox(height: defaultPadding),
                            if(!Responsive.isDesktop(context) && SelectWalletList)
                              SizedBox(height: defaultPadding),
                            if(!Responsive.isDesktop(context) && SelectWalletList)
                              WalletList(
                                  object: widget.wallet,
                                  objectColumnName: objectColumnNameOfWallet,
                                  title: "walletList",
                                  onWallet_Tran: updateWallet_Transaction,
                                  customer: selectedUser,
                                  token: widget.token),
                            if(!Responsive.isDesktop(context) && SelectTranList)
                              SizedBox(height: defaultPadding),
                            if(!Responsive.isDesktop(context) && SelectTranList)
                              TransactionList(
                                  object: widget.trans,
                                  objectColumnName: objectColumnNameOfTransaction,
                                  title: "transactionList",
                                  wallet: selectedWallet,
                                  currentPage: true),


                            SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            ),
          ]
        ),
      ) 
    );
  }
}

