// ignore_for_file: library_prefixes, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/presentation/screens/HomeScreens/header_text.dart';

import '../../../data/model/discount.dart';

class DiscountListWidget extends StatefulWidget {

  const DiscountListWidget({
    super.key,
    required this.discounts,
  });

  final List<Discount> discounts;

  @override
  State<DiscountListWidget> createState() =>
      _DiscountListWidgetState();
}

class _DiscountListWidgetState extends State<DiscountListWidget> {
  // Hàm tính khoảng cách
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderText(textInSpan1: "New", textInSpan2: "Discount"),
        SizedBox(height: Get.width/30,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.discounts.length,
                  (index) {
                var spot = widget.discounts[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 40),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(5.0),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ParkingSpotScreen(
                          //       data: spot,
                          //       userID: widget.userID,
                          //       userName: widget.userName,
                          //       isMonthly: false,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(Get.width / 30),
                              width: Get.width /2.2,
                              height: Get.width /5,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://via.placeholder.com/150"
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            Text(
                              spot.discountCode,
                              style: TextStyle(
                                fontSize: Get.width / 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: Get.width / 30),
                            Row(
                              children: [
                                Text("${spot.discountValue}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
