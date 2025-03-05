import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingapp/blocs/Slot/SlotState.dart';
import 'package:myparkingapp/data/model/parkingSlot.dart';
import 'package:myparkingapp/data/response/Slot/ListSlot.dart';
import 'package:myparkingapp/presentation/widgets/classInitial.dart';

import '../../../app/locallization/app_localizations.dart';

class FloorScreen extends StatefulWidget {

  final bool isMonthly;

  final FloorOfLot floorOfLot;
  const FloorScreen({super.key, required this.floorOfLot, required this.isMonthly});

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  List<ParkingSlot> car = [];
  List<ParkingSlot> moto = [];
  bool selectedDevice = true;
  ParkingSlot selectedSlot = selectedParkingSlotInitial;

  @override
  void initState() {
    super.initState();
    car = widget.floorOfLot.lists.carSlot;
    moto = widget.floorOfLot.lists.motoSlot;
  }
  @override
  void didUpdateWidget(covariant FloorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.floorOfLot != oldWidget.floorOfLot) {
      setState(() {
        // Load lại dữ liệu khi floorOfLot thay đổi
        car = widget.floorOfLot.lists.carSlot;
        moto = widget.floorOfLot.lists.motoSlot;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(Get.width/50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.center,

        children: [
          Center(child: Text("${AppLocalizations.of(context).translate("Floor")} ${widget.floorOfLot.floorName}"),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  selectedDevice = true;
                });
              },
                  child: Text(AppLocalizations.of(context).translate("Car"))),
              ElevatedButton(onPressed: (){
                setState(() {
                  selectedDevice = false;
                });
              },
                  child:  Text(AppLocalizations.of(context).translate("Moto")))
            ],
          ),
          selectedDevice?
          Flexible(child: _buildParkingSection("Car",car,true))
          :Flexible(child: _buildParkingSection("Moto",moto,false))
        ],
      ),
    );

  }
  Widget _buildParkingSection(String section, List<ParkingSlot> slots, bool isCar) {
    print("...........${slots.length}");
    return !slots.isEmpty ?Padding(
      padding: EdgeInsets.symmetric(vertical: Get.width / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                section,
                style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: Get.width / 30),
              Text(
                AppLocalizations.of(context).translate("Parking Slot"),
                style: TextStyle(color: Colors.grey, fontSize: Get.width / 25),
              ),
              SizedBox(width: Get.width / 30),
              const Icon(Icons.crop, color: Colors.blue, size: 20),
            ],
          ),
          SizedBox(height: Get.width / 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            itemCount: slots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2.5,
              crossAxisSpacing: Get.width / 30,
              mainAxisSpacing: Get.width / 30,
            ),
            itemBuilder: (context, index) {
              ParkingSlot slot = slots[index];
              return GestureDetector(
                onTap: () {
                  if ( slot.status.toString() == "AVAILABLE" ) {
                    setState(() {
                      selectedSlot = slot; // Cập nhật vị trí chọn
                    });
                    _showBookingDialog(slot,widget.isMonthly);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: slot.status == slotStatus.AVAILABLE ? Colors.blue :
                    slot.status == slotStatus.OCCUPIED ? Colors.red :
                    slot.status == slotStatus.RESERVED ? Colors.yellow :
                    Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: slot.status == slotStatus.OCCUPIED || slot.status == slotStatus.RESERVED ?
                  isCar
                      ? Image.asset(
                    'assets/images/detail/carImage.png',
                    width: Get.width/5,
                    height: 30,
                    fit: BoxFit.cover,
                  ) :  Image.asset(
                    'assets/images/detail/motoImage.png',
                    width: Get.width/5,
                    height: 30,
                    fit: BoxFit.cover,
                  ) : null,
                ),
              );
            },
          ),
        ],
      ),
    ) : const CircularProgressIndicator();
  }

  void _showBookingDialog(ParkingSlot slot,bool isMonthly) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return !isMonthly
            ?AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).translate("Parking Slot"),),
          content: Text(""),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).translate("Booking Now"), style: TextStyle(color: Colors.blue)),
              onPressed: () {
                //print('Vị trí đã chọn :$slot !'); // In ra vị trí đã chọn
                // Navigator.of(context).pop(); // Đóng dialog
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => ParkingBookingDetailScreen(
                //     parkingSpotModel: widget.parkingSpotModel,
                //     TypeSelected: selectedFloor,
                //     NameSlot: slot,
                //     userID: widget.userID,
                //     userName: widget.userName,
                //     isMonthly: widget.IsMonthly,
                //   )),
                // );
              },
            ),
            TextButton(

              child: Text(AppLocalizations.of(context).translate("Cancel"), style: TextStyle(color: Colors.grey)),
              onPressed: () {
                // setState(() {
                //   lostSlotCar = '';
                //   lostSlotMoto = '';// Reset vị trí chọn khi huỷ
                // });
                // Navigator.of(context).pop(); // Đóng dialog
              },
            ),
          ],
        )
            :AlertDialog(
          backgroundColor: Colors.white,

          title: Text(AppLocalizations.of(context).translate("Booking Monthly Now")),

          content: Text(
            '${AppLocalizations.of(context).translate('Selected parking slot:')} $slot of ${selectedSlot.slotName}',
          ),

          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).translate("Booking Now"), style: const TextStyle(color: Colors.grey)),
              onPressed: () {
                print('Vị trí đã chọn :$slot !'); // In ra vị trí đã chọn
                // Navigator.of(context).pop(); // Đóng dialog
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => ParkingBookingDetailScreen(
                //     parkingSpotModel: widget.parkingSpotModel,
                //     TypeSelected: selectedFloor,
                //     NameSlot: slot,
                //     userID: widget.userID,
                //     userName: widget.userName,
                //     isMonthly: widget.IsMonthly,)),
                // );
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).translate("Cancel"), style: TextStyle(color: Colors.grey)),
              onPressed: () {
                // setState(() {
                //   lostSlotCar = '';
                //   lostSlotMoto = '';// Reset vị trí chọn khi huỷ
                // });
                // Navigator.of(context).pop(); // Đóng dialog
              },
            ),
          ],
        )
        ;
      },
    );
  }
}
