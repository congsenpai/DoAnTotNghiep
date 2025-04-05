// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../constants.dart';
import '../../../data/dto/response/transaction_response.dart';

class TransactionDetail extends StatefulWidget {
  final TransactionResponse object;
  final VoidCallback onEdit;


  const TransactionDetail({
    super.key,
    required this.object,
    required this.onEdit,
  });

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  late final TextEditingController iconController;
  late final TextEditingController bankNameController;
  late final TextEditingController amountController;
  late final TextEditingController typeMoneyController;
  late final TextEditingController typeController;
  late final TextEditingController dateController;
  late final TextEditingController transactionIdController;
  late final TextEditingController walletIdController;
  late final TextEditingController descriptionController;
  late final TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    iconController = TextEditingController(text: widget.object.icon);
    bankNameController = TextEditingController(text: widget.object.bankName);
    amountController = TextEditingController(text: widget.object.amount.toString());
    typeMoneyController = TextEditingController(text: widget.object.typeMoney);
    typeController = TextEditingController(text: widget.object.type.toString().split('.').last); // Enum to String
    dateController = TextEditingController(text: widget.object.date.toString());
    transactionIdController = TextEditingController(text: widget.object.transactionId);
    walletIdController = TextEditingController(text: widget.object.walletId);
    descriptionController = TextEditingController(text: widget.object.description);
    statusController = TextEditingController(text: widget.object.status.toString().split('.').last); // Enum to String
  }

  @override
  void dispose() {
    iconController.dispose();
    bankNameController.dispose();
    amountController.dispose();
    typeMoneyController.dispose();
    typeController.dispose();
    dateController.dispose();
    transactionIdController.dispose();
    walletIdController.dispose();
    descriptionController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.object.transactionId} / ${AppLocalizations.of(context).translate("Transaction Detail")}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel,color: Colors.red,),
            onPressed: () {
              widget.onEdit(); // Call the callback to close the detail view
              // Refresh action can be added here if needed
            },
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldCustom(
                editController: iconController,
                title: "Icon",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: bankNameController,
                title: "Bank Name",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: amountController,
                title: "Amount",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: typeMoneyController,
                title: "Type of Money",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: typeController,
                title: "Transaction Type",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: dateController,
                title: "Date",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: transactionIdController,
                title: "Transaction ID",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: walletIdController,
                title: "Wallet ID",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: descriptionController,
                title: "Description",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: statusController,
                title: "Transaction Status",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
