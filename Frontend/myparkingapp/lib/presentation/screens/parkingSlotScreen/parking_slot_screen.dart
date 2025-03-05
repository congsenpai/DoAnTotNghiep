
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/Slot/ListSlot.dart';
import 'package:myparkingapp/presentation/widgets/classInitial.dart';

import '../../../data/model/parkingSlot.dart';
import '../../../data/model/user.dart';
import 'FloorScreen.dart';

class ParkingSlotScreen extends StatefulWidget {
  final String token;
  final bool IsMonthly;
  final User user;
  final List<FloorOfLot> lists;
  const ParkingSlotScreen({super.key, required this.lists, required this.IsMonthly, required this.user, required this.token});
  @override
  State<ParkingSlotScreen> createState() => _ParkingBookingScreenState();
}
class _ParkingBookingScreenState extends State<ParkingSlotScreen> {
  ParkingSlot selectedSlot = selectedParkingSlotInitial;
  List<String> floors = [];
  String selectedFloor = '';
  FloorOfLot floorOfLot = FloorOfLot(
    "Floor 1",
    ListSlot([],[],),
  );
  @override

  void initState() {
    super.initState();
    // Khởi tạo fetch dữ liệu khi widget được tạo
    floors = widget.lists.map((e) => e.floorName).toList();
    selectedFloor = floors[0];
    floorOfLot = widget.lists[0];
    print(floors.length);
    print(selectedFloor);
    print(floorOfLot.floorName);
  }
// Danh sách các vị trí đã có xe, sẽ cập nhật từ Firestore
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(Get.width/30),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).translate("Chosen Floor")),
              SizedBox(
                width: Get.width / 3, // Set chiều rộng bằng 1/3 màn hình
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Viền màu xám
                    borderRadius: BorderRadius.circular(8), // Bo góc viền
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10), // Padding bên trong
                  child: DropdownButtonHideUnderline( // Ẩn gạch chân mặc định
                    child: DropdownButton<String>(
                      value: selectedFloor,
                      isExpanded: true,
                      items: floors.map((floor) {
                        return DropdownMenuItem<String>(
                          value: floor,
                          child: Text(floor),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedFloor = newValue!;
                          floorOfLot = widget.lists.firstWhere(
                                (floors) => floors.floorName == selectedFloor,
                          );
                          print("...${floorOfLot.lists.motoSlot.length}___${floorOfLot.lists.carSlot.length} ");
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.width*5,
                child: FloorScreen(floorOfLot: floorOfLot, isMonthly: false,)
              )
            ],
          ),
        ),
      ),
    );
  }
  // Parking section widget
  // Phương thức để hiển thị thông báo nổi
}


