// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myparkingapp/data/response/parking_lot.dart';
import 'package:myparkingapp/data/response/parking_slots.dart';
import 'package:myparkingapp/data/response/user.dart';

import '../../../constants.dart';
import '../../../screens/details/details_screen.dart';
import '../../vehicle_type_list.dart';
import '../../rating_with_counter.dart';
import '../../small_dot.dart';
import 'big_card_image_slide.dart';

class ParkingLotInfoBigCard extends StatefulWidget {
  final User user; 
  final ParkingLot parkingLot;
  final VoidCallback press;

  const ParkingLotInfoBigCard({
    super.key,
    required this.parkingLot,
    required this.press, required this.user,
  });

  @override
  State<ParkingLotInfoBigCard> createState() => _ParkingLotInfoBigCardState();
}

class _ParkingLotInfoBigCardState extends State<ParkingLotInfoBigCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass list of images here
          BigCardImageSlide(images: widget.parkingLot.images.map((image)=>image.url).toList()),
          const SizedBox(height: defaultPadding / 2),
          Text(widget.parkingLot.parkingLotName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: defaultPadding / 4),
          VehicleTypeList(typeList: ["vehicle","car"]),
          const SizedBox(height: defaultPadding / 4),
          Row(
            children: [
              RatingWithCounter(rating: widget.parkingLot.rate, numOfRating: 10000),
              const SizedBox(width: defaultPadding / 2),
              SvgPicture.asset(
                "assets/icons/clock.svg",
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
              Text(
                "20 Min",
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
              Text(widget.parkingLot.status.name.toString(),
                  style: Theme.of(context).textTheme.labelSmall),

            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ParkingLotList extends StatefulWidget {
  final List<ParkingLot> lots;
  final User user;


  const ParkingLotList({super.key, required this.lots, required this.user});

  @override
  State<ParkingLotList> createState() => _ParkingLotListState();
}

class _ParkingLotListState extends State<ParkingLotList> {
  late List<ParkingLot> displayLots;

  @override
  void initState() {
    super.initState();
    displayLots = widget.lots; // init ban đầu
  }

  @override
  void didUpdateWidget(covariant ParkingLotList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lots != widget.lots) {
      setState(() {
        displayLots = widget.lots; // cập nhật khi widget.lots đổi
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        displayLots.length,
            (index) {
          final lot = displayLots[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, defaultPadding),
            child: ParkingLotInfoBigCard(
              user: widget.user,
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(parkingLot: lot, user: widget.user),
                ),
              ),
              parkingLot: lot,
            ),
          );
        },
      ),
    );
  }
}



