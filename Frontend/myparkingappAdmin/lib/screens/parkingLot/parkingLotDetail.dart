// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../../constants.dart';
import '../../../app/localization/app_localizations.dart';

class ParkingSpotDetail extends StatefulWidget {
  final ParkingLotResponse parkingLot;
    final VoidCallback onEdit;
  

  const ParkingSpotDetail({
    super.key,
    required this.parkingLot, required this.onEdit
  });

  @override
  State<ParkingSpotDetail> createState() => _ParkingSpotDetailState();
}

class _ParkingSpotDetailState extends State<ParkingSpotDetail> {
  bool isEdit = false; // Biến để lưu trạng thái hợp đồng
  List<String> images = []; // Danh sách hình ảnh
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _totalSlotController;
  late TextEditingController _rateController;
  late TextEditingController _descriptionController;

  @override
  @override
  void initState() {
    super.initState();

    // Giả sử bạn có biến widget.parkingLot chứa dữ liệu
    _nameController =
        TextEditingController(text: widget.parkingLot.parkingLotName);
    _addressController = TextEditingController(text: widget.parkingLot.address);
    _latitudeController =
        TextEditingController(text: widget.parkingLot.latitude.toString());
    _longitudeController =
        TextEditingController(text: widget.parkingLot.longitude.toString());
    _totalSlotController =
        TextEditingController(text: widget.parkingLot.totalSlot.toString());
    _rateController =
        TextEditingController(text: widget.parkingLot.rate.toString());
    _descriptionController =
        TextEditingController(text: widget.parkingLot.description);
    images = widget.parkingLot
        .images; // Giả sử bạn có danh sách hình ảnh từ đối tượng ParkingLotResponse
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate("Parking Lot Detail")),
        actions: [
          isEdit
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    UpdateParkingLotRequest request = UpdateParkingLotRequest(
                      parkingLotName: _nameController.text,
                      address: _addressController.text,
                      latitude: double.parse(_latitudeController.text),
                      longitude: double.parse(_longitudeController.text),
                      description: _descriptionController.text,
                    );
                  
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEdit = true; // Chuyển sang chế độ chỉnh sửa
                    });
                  },
                ),
        ],
      ),
      body: Container(
        width: Get.width / 1.2,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images
                    .map((e) => Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(right: defaultPadding),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(e),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: defaultPadding),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(height: defaultPadding),
                        TextFieldCustom(
                          editController: _nameController,
                          title: 'ParkingLotName',
                          isEdit: isEdit,
                        ),
                        SizedBox(height: defaultPadding),
                        TextFieldCustom(
                          editController: _latitudeController,
                          title: 'Lattitude',
                          isEdit: false,
                        ),
                        SizedBox(height: defaultPadding),
                        TextFieldCustom(
                          editController: _longitudeController,
                          title: 'Longtitude',
                          isEdit: false,
                        ),
                        SizedBox(height: defaultPadding),
                      ],
                    )),
                SizedBox(width: defaultPadding),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        TextFieldCustom(
                          editController: _addressController,
                          title: 'Address',
                          isEdit: isEdit,
                        ),
                        SizedBox(height: defaultPadding),
                        TextFieldCustom(
                          editController: _rateController,
                          title: 'Rate',
                          isEdit: false,
                        ),
                        SizedBox(height: defaultPadding),
                        TextFieldCustom(
                          editController: _totalSlotController,
                          title: 'Total Slot',
                          isEdit: false,
                        ),
                        SizedBox(height: defaultPadding),
                      ],
                    )),
              ],
            ),
            SizedBox(height: defaultPadding),

            TextFieldCustom(
              editController: _descriptionController,
              title: 'Description',
              isEdit: isEdit,
            ),

            SizedBox(height: defaultPadding),
            // Tiêu đề
          ],
        ),
      ),
    );
  }
}
