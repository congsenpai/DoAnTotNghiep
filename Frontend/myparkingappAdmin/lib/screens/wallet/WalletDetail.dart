// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../constants.dart';
import '../../../data/dto/response/wallet_response.dart';

class WalletDetail extends StatefulWidget {
  final WalletResponse object;
  final VoidCallback onEdit;

  const WalletDetail({
    super.key,
    required this.object,
    required this.onEdit,
  });

  @override
  State<WalletDetail> createState() => _WalletDetailState();
}

class _WalletDetailState extends State<WalletDetail> {
  bool isEdit = false;

  late final TextEditingController walletIdController;
  late final TextEditingController userIdController;
  late final TextEditingController svgSrcController;
  late final TextEditingController nameController;
  late final TextEditingController balanceController;
  late final TextEditingController statusController;
  late final TextEditingController currencyController;

  @override
  void initState() {
    super.initState();
    walletIdController = TextEditingController(text: widget.object.walletId);
    userIdController = TextEditingController(text: widget.object.userId);
    svgSrcController = TextEditingController(text: widget.object.svgSrc);
    nameController = TextEditingController(text: widget.object.name);
    balanceController =
        TextEditingController(text: widget.object.balance.toString());
    statusController =
        TextEditingController(text: widget.object.status ? "ACTIVE" : "INACTIVE");
    currencyController = TextEditingController(text: widget.object.currency);
  }

  @override
  void dispose() {
    walletIdController.dispose();
    userIdController.dispose();
    svgSrcController.dispose();
    nameController.dispose();
    balanceController.dispose();
    statusController.dispose();
    currencyController.dispose();
    super.dispose();
  }

  void _onSave() {
    widget.onEdit(); // Gọi callback khi lưu
    Get.snackbar("Success", "Wallet updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.object.name} / ${AppLocalizations.of(context).translate("Wallet Detail")}"),
        actions: [
          IconButton(
            icon: Icon(isEdit ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEdit) _onSave();
              setState(() {
                isEdit = !isEdit;
              });
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
                editController: walletIdController,
                title: "Wallet ID",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: userIdController,
                title: "User ID",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: svgSrcController,
                title: "SVG Icon URL",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: nameController,
                title: "Name",
                isEdit: isEdit,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: balanceController,
                title: "Balance",
                isEdit: isEdit,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: statusController,
                title: "Status",
                isEdit: isEdit, // Có thể đổi qua Switch cũng được
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: currencyController,
                title: "Currency",
                isEdit: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
