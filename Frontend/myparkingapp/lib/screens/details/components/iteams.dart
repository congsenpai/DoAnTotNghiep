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
import '../../addToOrder/add_to_order_screen.dart';

class Items extends StatelessWidget {
  final List<Slot> slots;
  const Items({super.key, required this.slots});

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
            flex: 1,
            child: Column(
              children: List.generate(
                firstColumnData.length,
                    (index) => Container(
                      height: Get.width / 3, // Tăng chiều cao để chứa đầy đủ nội dung
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: ElevatedButton(
                        onPressed: () {
                          secondColumnData[index].slotStatus == SlotStatus.AVAILABLE
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddToOrderScrreen(),
                            ),
                          )
                              : AppDialog.showMessage(context, "This Slot was not available");
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.width / 6, // Cố định kích thước hình ảnh
                              width: double.infinity,
                              child: Image.asset(
                                "assets/images/motoImage.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context).translate("Month cost")),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                  child: SmallDot(),
                                ),
                                Text("${secondColumnData[index].pricePerMonth}"),
                                const Spacer(),
                                Text("VND ${secondColumnData[index].pricePerHour}/h,"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(width: defaultPadding), // Spacing between columns
          // Second Column
          Expanded(
            flex: 1,
            child: Column(
              children: List.generate(
                secondColumnData.length,
                    (index) => Container(
                      color: secondColumnData[index].slotStatus == SlotStatus.AVAILABLE ? Colors.blue :
                      secondColumnData[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red,
                      height: Get.width / 6, // Tăng chiều cao để chứa đầy đủ nội dung
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: ElevatedButton(
                        onPressed: () {
                          secondColumnData[index].slotStatus == SlotStatus.AVAILABLE
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddToOrderScrreen(),
                            ),
                          )
                              : AppDialog.showMessage(context, "This Slot was not available");
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.width / 6, // Cố định kích thước hình ảnh
                              width: double.infinity,
                              child: Icon(Icons.motorcycle_outlined)
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(secondColumnData[index].slotName),
                                Text("VND ${secondColumnData[index].pricePerHour}/h,"),
                              ],
                            ),
                          ],
                        ),
                      ),
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
