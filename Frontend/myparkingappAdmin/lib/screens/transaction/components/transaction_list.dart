// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/dto/response/transaction.dart';
import 'package:intl/intl.dart';
import 'package:myparkingappadmin/dto/response/wallet.dart';
import 'package:myparkingappadmin/screens/transaction/components/transaction_detail.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> object;
  final String title;
  final HashSet<String> objectColumnName;
  final Wallet wallet;
  final bool currentPage;

  const TransactionList({
    super.key,
    required this.object,
    required this.objectColumnName,
    required this.title,
    required this.wallet,
    required this.currentPage,
  });

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<Transaction> _filteredTrans = [];

  @override
  void initState() {
    super.initState();
    _filteredTrans = widget.object;
  }

  @override
  void didUpdateWidget(covariant TransactionList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.wallet.walletId != widget.wallet.walletId ||
        oldWidget.object != widget.object) {
      setState(() {
        _filteredTrans = widget.object.toList();
      });
    }
  }

  void _filterByDate() {
    setState(() {
      _filteredTrans = widget.object.where((tran) {
        if (_startDate == null || _endDate == null) return true;
        return tran.date.isAfter(_startDate!.subtract(Duration(days: 1))) &&
            tran.date.isBefore(_endDate!.add(Duration(days: 1)));
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        _filterByDate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 16.0),
            Row(
              children: [
                _buildDateButton(context, true, _startDate),
                const SizedBox(width: 8),
                _buildDateButton(context, false, _endDate),
              ],
            ),
            const SizedBox(height: 16.0),
            _filteredTrans.isEmpty
                ? Center(
              child: Text(
                AppLocalizations.of(context).translate(
                    "There is no matching information"),
              ),
            )
                : SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 16.0,
                columns: widget.objectColumnName
                    .map((name) => DataColumn(
                  label: Text(
                    AppLocalizations.of(context).translate(name),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ))
                    .toList(),
                rows: _filteredTrans
                    .map((tran) => _buildDataRow(tran))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateButton(BuildContext context, bool isStartDate, DateTime? date) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 1,
            ),
          ),
        ),
        onPressed: () => _selectDate(context, isStartDate),
        child: Text(
          date == null
              ? AppLocalizations.of(context)
              .translate(isStartDate ? "startD" : "endD")
              : DateFormat('dd/MM/yyyy').format(date),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(Transaction tran) {
    return DataRow(
      cells: [
        DataCell(Text(tran.transactionId)),
        DataCell(Text(DateFormat('dd/MM/yyyy').format(tran.date))),
        DataCell(Text(tran.amount.toString())),
        DataCell(
          IconButton(
            icon: const Icon(Icons.details, color: Colors.green),
            onPressed: () => _showDetailDialog(context, tran),
          ),
        ),
      ],
    );
  }

  void _showDetailDialog(BuildContext context, Transaction tran) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate("Transaction Detail")),
          content: TransactionDetail(object: tran, title: "TransactionDetail"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.cancel, color: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
