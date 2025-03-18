import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/parking_lot.dart';
import '../../../app/locallization/app_localizations.dart';
import '../../../components/cards/iteam_card.dart';
import '../../../components/small_dot.dart';
import '../../../constants.dart';
import '../../../data/parking_slots.dart';
import '../../booking/booking_screen.dart';

class Items extends StatelessWidget {
  final ParkingLot lot;
  final String token;
  final List<Slot> slots;
  const Items({super.key, required this.slots, required this.lot, required this.token});

  @override
  Widget build(BuildContext context) {
    // Split demoData into 2 parts for 2 columns
    List<Slot> firstColumnData = slots.where((slot)=>slot.vehicleType.name == 'CAR').toList();
    List<Slot> secondColumnData = slots.where((slot)=>slot.vehicleType.name == 'MOTORCYCLE').toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Column
          Expanded(
            flex: 5,
            child: Column(
              children: List.generate(
                firstColumnData.length,
                    (index) => Container(
                      color: Colors.transparent,
                      height: Get.width / 4, // Tăng chiều cao để chứa đầy đủ nội dung
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(firstColumnData[index].slotStatus == SlotStatus.AVAILABLE ? Colors.green[300] :
                          firstColumnData[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red),
                        ),
                        onPressed:(){
                          firstColumnData[index].slotStatus == SlotStatus.AVAILABLE
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(lot: lot, slot: firstColumnData[index], token: token,),
                            ),
                          ):AppDialog.showErrorEvent(context, "This Slot was not available");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 1, child: Text("A1",style: TextStyle(fontSize: Get.width/20),)),
                            Expanded(flex: 2, child: Image.asset("assets/icons/icon_car.png",fit: BoxFit.cover,),)
                          ],
                        ),)
                    ),
              ),
            ),
          ),
          SizedBox(width: Get.width / 10), // Spacing between columns
          // Second Column
          Expanded(
            flex: 4,
            child: Column(
              children: List.generate(
                secondColumnData.length,
                    (index) => Container(
                        padding: EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                        height: Get.width / 6, width: Get.width/4,// Tăng chiều cao để chứa đầy đủ nội dung
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(secondColumnData[index].slotStatus == SlotStatus.AVAILABLE ? Colors.green[300] :
                            secondColumnData[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red),
                          ),
                          onPressed:(){
                            secondColumnData[index].slotStatus == SlotStatus.AVAILABLE
                                ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(lot: lot, slot: secondColumnData[index], token: token,),
                              ),
                            ):AppDialog.showErrorEvent(context, "This Slot was not available");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: Text("A1",style: TextStyle(fontSize: Get.width/40),)),
                              Expanded(flex: 2, child: Image.asset("assets/icons/icon_moto.png",fit: BoxFit.cover,),)
                            ],
                          ),)
                    ),
                ),
              ),
            ),
          Expanded(
            flex: 4,
            child: Column(
              children: List.generate(
                secondColumnData.length,
                    (index) => Container(
                    padding: EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                    height: Get.width / 6, width: Get.width/4,// Tăng chiều cao để chứa đầy đủ nội dung
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(secondColumnData[index].slotStatus == SlotStatus.AVAILABLE ? Colors.green[300] :
                        secondColumnData[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red),
                      ),
                      onPressed:(){
                        secondColumnData[index].slotStatus == SlotStatus.AVAILABLE
                            ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(lot: lot, slot: secondColumnData[index], token: token,),
                          ),
                        ):AppDialog.showErrorEvent(context, "This Slot was not available");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 1, child: Text("A1",style: TextStyle(fontSize: Get.width/40),)),
                          Expanded(flex: 2, child: Image.asset("assets/icons/icon_moto.png",fit: BoxFit.cover,),)
                        ],
                      ),)
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> demoData = List.generate(
  4, // Now with 4 items to make 2 per column
      (index) => {
    "image": "assets/images/featured _items_${index + 1}.png",
    "title": "Cookie Sandwich ${index + 1}",
    "description": "Shortbread, chocolate turtle cookies, and red velvet.",
    "price": 7.4,
    "foodType": "Chinese",
    "priceRange": "\$" * 2,
  },
);


