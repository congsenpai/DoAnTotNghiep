import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingapp/data/response/parking_lot.dart';
import 'package:myparkingapp/data/response/parking_slots.dart';
import 'package:myparkingapp/data/response/service.dart';

import '../../../constants.dart';
import '../../../screens/details/details_screen.dart';
import '../../vehicle_type_list.dart';
import '../../rating_with_counter.dart';
import '../../small_dot.dart';
import 'big_card_image.dart';
import 'big_card_image_slide.dart';

class ServiceInfoBigCard extends StatefulWidget {
  final Service service;
  final VoidCallback press;

  const ServiceInfoBigCard({
    super.key,
    required this.service,
    required this.press,
  });

  @override
  State<ServiceInfoBigCard> createState() => _ServiceInfoBigCardState();
}

class _ServiceInfoBigCardState extends State<ServiceInfoBigCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass list of images here
        Container(
          width: Get.width/1.1,
          height: Get.width/2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(
              // for network image use NetworkImage()
              image: AssetImage(widget.service.image,),
              fit: BoxFit.cover,
            ),
          ),
        ),
          const SizedBox(height: defaultPadding / 2),
          Text(widget.service.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: defaultPadding / 4),
          Row(
            children: [
              RatingWithCounter(rating: widget.service.version, numOfRating: 10000),
              const SizedBox(width: 8),
              Text(
                widget.service.description,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: SmallDot(),
              ),
              SvgPicture.asset(
                "assets/icons/delivery.svg",
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

// class ParkingLotList extends StatelessWidget {
//   final List<ParkingLot> lots;
//
//   const ParkingLotList({super.key, required this.lots});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Column(
//       children: List.generate(
//         lots.length,
//             (index) {
//           final lot = lots[index]; // Lấy phần tử hiện tại
//           return Padding(
//             padding: const EdgeInsets.fromLTRB(
//                 defaultPadding, 0, defaultPadding, defaultPadding),
//             child: ServiceInfoBigCard(
//
//                // Trạng thái miễn phí (tuỳ chỉnh theo logic VD: còn trống, miễn phí...)
//               press: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const DetailsScreen(), // Chuyển sang màn chi tiết
//                 ),
//               ), service: lots,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


