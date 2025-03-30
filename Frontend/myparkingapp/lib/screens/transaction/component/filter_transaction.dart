// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:myparkingapp/data/response/wallet__response.dart';

class FilterTransaction extends StatefulWidget {
  final WalletResponse wallet;
  final List<TransactionResponse> trans;
  final Transactions type;
  final DateTime start;
  final DateTime end;

  const FilterTransaction({
    super.key,
    required this.type,
    required this.start,
    required this.end,
    required this.wallet,
    required this.trans,
  });

  @override
  State<FilterTransaction> createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {
  late Transactions selectType;
  late DateTime startSelect;
  late DateTime endSelect;

  @override
  void initState() {
    super.initState();
    selectType = widget.type;
    startSelect = widget.start;
    endSelect = widget.end;
  }

  // Hàm chọn ngày
  Future<void> _pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startSelect : endSelect,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startSelect = picked;
        } else {
          endSelect = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền xám nhạt
        borderRadius: BorderRadius.circular(12), // Bo góc nhẹ
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Màu bóng nhẹ
            spreadRadius: 1, // Độ lan của bóng
            blurRadius: 8, // Độ mờ của bóng
            offset: Offset(2, 4), // Vị trí bóng đổ (x, y)
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(AppLocalizations.of(context).translate("From")),
              TextButton(
                onPressed: () => _pickDate(context, true),
                child: Text("${startSelect.toLocal()}".split(' ')[0]),
              ),
              Text(AppLocalizations.of(context).translate("To")),
              TextButton(
                onPressed: () => _pickDate(context, false),
                child: Text("${endSelect.toLocal()}".split(' ')[0]),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectType = Transactions.TOP_UP;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectType == Transactions.TOP_UP
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("TOP_UP")),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectType = Transactions.PAYMENT;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectType == Transactions.PAYMENT
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("PAYMENT")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TransactionBloc>().add(
                          LoadTransactionEvent(
                            widget.wallet,
                            startSelect,
                            endSelect,
                            selectType,
                            1,
                          ),
                        );
                  },
                  child: Text(AppLocalizations.of(context).translate("Filter")),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<TransactionBloc>()
                        .add(LoadAllTransactionEvent(widget.wallet, 1));
                  },
                  child: Text(AppLocalizations.of(context).translate("Empty")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
