import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myparkingapp/data/parking_lot.dart';

import '../../constants.dart';
import '../search/search_screen.dart';
import 'components/featured_items.dart';
import 'components/iteams.dart';
import 'components/lot_info.dart';

class DetailsScreen extends StatelessWidget {
  final ParkingLot parkingLot;
  const DetailsScreen({super.key, required this.parkingLot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/share.svg"),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: defaultPadding / 2),
              ParkingLotInfo(lot: parkingLot,),
              SizedBox(height: defaultPadding),
              FeaturedItems(images: parkingLot.images,),
              Items(),
            ],
          ),
        ),
      ),
    );
  }
}
