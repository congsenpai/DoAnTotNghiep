// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../constants.dart';
import '../../app/localization/app_localizations.dart';
import '../../dto/response/discount.dart';

class DiscountDetail extends StatefulWidget {
  final String title;

  final Discount object;

  const DiscountDetail({
    super.key,
    required this.object,
    required this.title,
  });

  @override
  State<DiscountDetail> createState() => _DiscountDetailState();
}

class _DiscountDetailState extends State<DiscountDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width/1.2,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate(widget.title),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        // Add your save functionality here
                      },
                    ),
                  ],
                ),
              ],
            ),
            ObjectDetailInfo(objectInfo: widget.object)
          ],
        ),
      ),
    );
  }
}


class ObjectDetailInfo extends StatefulWidget {
  final Discount objectInfo;

  const ObjectDetailInfo({super.key, required this.objectInfo});

  @override
  State<ObjectDetailInfo> createState() => _ObjectDetailInfoState();
}

class _ObjectDetailInfoState extends State<ObjectDetailInfo> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: defaultPadding),
          SizedBox(height: defaultPadding),
          
          // Dropdown thay thế TextField
          Table(
            border: TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
            columnWidths: const {
              0: FlexColumnWidth(2), // Cột 1 rộng hơn
              1: FlexColumnWidth(3), // Cột 2 rộng hơn để chứa dữ liệu
            },
            children: [
              _buildTableRow('Code', widget.objectInfo.discountCode),
              _buildTableRow('Type', widget.objectInfo.discountType.toString()),
              _buildTableRow('DiscountValue', widget.objectInfo.discountValue.toString()),
              _buildTableRow("Description",  widget.objectInfo.description)
            ],
          ),

          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
  TableRow _buildTableRow(String field, String value) {
    return TableRow(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              AppLocalizations.of(context).translate(field)
              , style: TextStyle( color: Theme.of(context).colorScheme.onPrimary)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value,style: TextStyle( color: Theme.of(context).colorScheme.onPrimary)),
        ),
      ],
    );
  }
}
