// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../constants.dart';
import '../../app/localization/app_localizations.dart';
import '../../models/parkingSlot.dart';


class ParkingSlotDetail extends StatefulWidget {
  final String title;
  final ParkingSlot object;
  const ParkingSlotDetail({
    super.key,
    required this.object,
    required this.title,
  });

  @override
  State<ParkingSlotDetail> createState() => _ParkingSlotDetailState();
}

class _ParkingSlotDetailState extends State<ParkingSlotDetail> {
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
            ObjectDetailInfo(objectInfo: widget.object)
          ],
        ),
      ),
    );
  }
}


class ObjectDetailInfo extends StatefulWidget {
  final ParkingSlot objectInfo;

  const ObjectDetailInfo({super.key, required this.objectInfo});

  @override
  State<ObjectDetailInfo> createState() => _ObjectDetailInfoState();
}

class _ObjectDetailInfoState extends State<ObjectDetailInfo> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: defaultPadding),
          // Dropdown thay thế TextField
          Table(
            border: TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
            columnWidths: const {
              0: FlexColumnWidth(2), // Cột 1 rộng hơn
              1: FlexColumnWidth(3), // Cột 2 rộng hơn để chứa dữ liệu
            },
            children: [
              _buildTableRow('SlotName', widget.objectInfo.slotName),
              _buildTableRow('Status', widget.objectInfo.slotStatus),
              _buildTableRow('Vehicle Type', widget.objectInfo.vehicleType),
              _buildTableRow('Price Per Hour', widget.objectInfo.pricePerHour.toString()),
              _buildTableRow('Price Per Month', widget.objectInfo.pricePerMonth.toString()),
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
