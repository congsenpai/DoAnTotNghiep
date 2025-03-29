import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';
import 'package:myparkingapp/data/response/user__response.dart';

class FilterTransactionDBoard extends StatefulWidget {
  final UserResponse user;
  final List<TransactionResponse> trans;
  final Transactions type;
  final DateTime start;
  final DateTime end;

  const FilterTransactionDBoard({
    super.key,
    required this.type,
    required this.start,
    required this.end,
    required this.user,
    required this.trans,
  });

  @override
  State<FilterTransactionDBoard> createState() => _FilterTransactionDBoardState();
}

class _FilterTransactionDBoardState extends State<FilterTransactionDBoard> {
  late Transactions selectType;
  late DateTime startSelect;
  late DateTime endSelect;
  // Hàm chọn ngày
@override
  void initState() {
    super.initState();
    selectType = widget.type;
    endSelect = DateTime.now(); // Ngày hiện tại
    startSelect = endSelect.subtract(const Duration(days: 30)); // 30 ngày trước
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startSelect : endSelect,
      firstDate: DateTime.now().subtract(const Duration(days: 365)), // Giới hạn 1 năm trước
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
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).translate("From"), style: TextStyle(color:Colors.white, fontSize: 15),),
              TextButton(
                onPressed: () => _pickDate(context, true),
                child: Text("${startSelect.toLocal()}".split(' ')[0], style: TextStyle(color:Colors.lightGreenAccent, fontSize: 15),),
              ),
              Text(AppLocalizations.of(context).translate("To"), style: TextStyle(color:Colors.white, fontSize: 15),),
              TextButton(
                onPressed: () => _pickDate(context, false),
                child: Text("${endSelect.toLocal()}".split(' ')[0], style: TextStyle(color:Colors.lightGreenAccent, fontSize: 15),),
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
                    context.read<TransactionBloc>().add(LoadAllTransactionByTimeEvent(widget.user,startSelect,
                            endSelect,
                            selectType,));
                  },
                  child: Text(AppLocalizations.of(context).translate("Filter")),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TransactionBloc>().add(LoadAllTransactionByTimeEvent(widget.user,startSelect,
                            endSelect,
                            selectType,));
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
