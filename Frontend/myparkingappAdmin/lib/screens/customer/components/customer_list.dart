// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/Customer_Wallet/customer_wallet_state.dart';
import 'package:myparkingappadmin/bloc/customer_wallet/customer_wallet_bloc.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

import 'customer_detail.dart';

// ignore: must_be_immutable
class CustomerList extends StatefulWidget {
  final String token;
  final Function(UserResponse) onCustomer_Wallet;

  const CustomerList({
    super.key,
    required this.onCustomer_Wallet,
    required this.token,
  });

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final HashSet<String> objectColumnNameOfCustomer = HashSet.from([
    "FirstName",
    "LastName",
    "Detail",
    "WalletList"
  ]);
  final TextEditingController _searchController = TextEditingController();
  List<UserResponse> customers = [];



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerWalletBloc,CustomerWalletState>(
      builder: (context,state){
        if(state is CustomerWalletLoadingState){
          Center(child: CircularProgressIndicator(),);
        }
        else if(state is CustomerWalletLoadedState){
          return Container(
            height: Get.height / 2,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("CustormerList"),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: defaultPadding),
                  Container(
                    child: customers.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context).translate("There is no matching information"),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columnSpacing: defaultPadding,
                            columns: objectColumnNameOfCustomer
                                .map(
                                  (name) => DataColumn(
                                    label: Text(
                                      AppLocalizations.of(context).translate(name),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                )
                                .toList(),
                            rows: customers.map((lotOwner) {
                              return _buildDataRow(lotOwner, context);
                            }).toList(),
                          ),
                        ),
                  )
                ],
              ),
            ),
          
          );
  

        }
        return Center(child: CircularProgressIndicator(),);
      }, listener: (context,state){

      });
    
  }

  DataRow _buildDataRow(UserResponse user, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(user.firstName)),
        DataCell(Text(user.lastName)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.details, color: Colors.green),
            onPressed: () => _showDetailDialog(context, user),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.content_paste_search_outlined, color: Colors.blueAccent),
            onPressed: () => widget.onCustomer_Wallet(user),
          ),
        ),
      ],
    );
  }

  void _showDetailDialog(BuildContext context, UserResponse user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: CustomerDetail(
            object: user,
            isImage: true,
            title: 'CustomerDetail',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel, color: Colors.red,),
            ),
          ],
        );
      },
    );
  }
}
