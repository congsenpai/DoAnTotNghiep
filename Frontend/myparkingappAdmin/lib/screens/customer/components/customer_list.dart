// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

import '../../../models/user.dart';
import 'customer_detail.dart';

class CustomerList extends StatefulWidget {
  final List<User> object;
  final String title;
  final HashSet<String> objectColumnName;
  final Function(User) onCustomer_Wallet;

  const CustomerList({
    super.key,
    required this.object,
    required this.objectColumnName,
    required this.title,
    required this.onCustomer_Wallet,
  });

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredCustomer = [];

  @override
  void initState() {
    super.initState();
    _filteredCustomer = widget.object;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchUser() {
    String query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _filteredCustomer = widget.object);
      return;
    }
    setState(() {
      _filteredCustomer = widget.object.where((user) {
        return user.firstName.toLowerCase().contains(query) ||
               user.lastName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              AppLocalizations.of(context).translate(widget.title),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: defaultPadding),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate("Finding..."),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onSubmitted: (_) => _searchUser(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: _searchUser,
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            _filteredCustomer.isEmpty
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
                      columns: widget.objectColumnName
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
                      rows: _filteredCustomer.map((lotOwner) {
                        return _buildDataRow(lotOwner, context);
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(User user, BuildContext context) {
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

  void _showDetailDialog(BuildContext context, User user) {
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
