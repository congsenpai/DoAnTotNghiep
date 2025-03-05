// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myparkingapp/data/model/parkingLot.dart';
//
//
// import '../../data/model/user.dart';
// import '../screens/detailParkingSpotScreen/detail_parking_spot_screent.dart';
//
// class SpotItem extends StatefulWidget {
//   final ParkingLot data;
//   final User user;
//   const SpotItem({super.key,
//     required this.data, required this.user,
//   });
//   @override
//   State<SpotItem> createState() => _SpotItemState();
// }
//
// class _SpotItemState extends State<SpotItem> {
//   @override
//   Widget build(BuildContext context) {
//     final String title = widget.data.parkingLotName;
//     final String imageUrl = widget.data.listImage[0];
//     return Container(
//       margin: EdgeInsets.only(top: Get.width /25),
//       width: Get.width/1.6,
//       height: Get.width/4,
//       padding: EdgeInsets.all(Get.width/40),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: Get.width / 5, // Sửa lại để đảm bảo kích thước hiển thị phù hợp.
//             width: Get.width / 5,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               image: DecorationImage(
//                 image: NetworkImage(
//                   "https://drive.google.com/uc?export=view&id=$imageUrl",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'Car: ${widget.data.costPerHourCar*30*3}',
//                 style: const TextStyle(color: Colors.grey),
//               ),
//               Text(
//                 'Moto: ${widget.data.costPerHourMoto*30*3}',
//                 style: const TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//           SizedBox(width: Get.width/20,),
//           ElevatedButton(onPressed: (){
//             Get.to(ParkingSpotScreen(data: widget.data, userID: widget.userModel.userID, userName: widget.userModel.username, isMonthly: true,));
//           },
//               child: Text('Chi tiết')
//           )
//         ],
//       ),
//     );
//   }
// }