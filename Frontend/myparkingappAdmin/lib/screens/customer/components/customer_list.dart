// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/customer/customer_bloc.dart';
import 'package:myparkingappadmin/bloc/customer/customer_event.dart';
import 'package:myparkingappadmin/bloc/customer/customer_state.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/general/search.dart';
import 'package:myparkingappadmin/screens/myprofile/components/customer_detail.dart';
import 'package:myparkingappadmin/screens/wallet/WalletList.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class CustomerList extends StatefulWidget {
  const CustomerList({
    super.key,
  });

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<UserResponse> customers = [];
  bool isDetail = false;
  UserResponse user = UserResponse.empty();
  final HashSet<String> objectColumnNameOfCustomer =
      HashSet.from(["FullName", "Detail", "Wallets"]);
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(LoadedCustomerScreenEvent("_"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, UserState>(builder: (context, state) {
      if (state is CustomerLoadingState) {
        Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CustomerLoadedState) {
        customers = state.customerList;
        return Scaffold(
          appBar: AppBar(
              title: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate("CUSTOMER"),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 5,
                child: Search(onSearch: (value) {
                  context
                      .read<CustomerBloc>()
                      .add(LoadedCustomerScreenEvent(value));
                }),
              ),
            ],
          )),
          body: Container(
              height: Get.height,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        Container(
                          child: customers.isEmpty
                              ? Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate(
                                        "There is no matching information"),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                              AppLocalizations.of(context)
                                                  .translate(name),
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
                  SizedBox(
                    width: 10,
                  ),
                  isDetail
                      ? Expanded(
                          child: UserDetail(
                            user: user,
                          ),
                        )
                      : SizedBox(
                          width: 0,
                        )
                ],
              )),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    }, listener: (context, state) {
      if (state is CustomerErrorState) {
        AppDialog.showErrorEvent(context, state.mess);
      } else if (state is UserErrorState) {
        AppDialog.showErrorEvent(context, state.mess);
      } else if (state is UserSuccessState) {
        AppDialog.showSuccessEvent(context, state.mess);
      }
    });
  }

  DataRow _buildDataRow(UserResponse user, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text("${user.lastName} ${user.firstName} ")),
        DataCell(
          IconButton(
              icon: const Icon(Icons.details, color: Colors.green),
              onPressed: () => {
                    isDetail = true,
                    setState(() {
                      this.user = user;
                    })
                  }),
        ),
        DataCell(
          IconButton(
              icon: const Icon(Icons.content_paste_search_outlined,
                  color: Colors.blueAccent),
              onPressed: () => {
                    isDetail = true,
                    setState(() {
                      this.user = user;
                    }),
                    _showWalletDialog(context, user),
                  }),
        ),
      ],
    );
  }

  void _showWalletDialog(BuildContext context, UserResponse user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: WalletList(customerId: user.userId,),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
