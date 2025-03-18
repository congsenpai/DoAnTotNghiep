import 'package:flutter/material.dart';
import 'package:myparkingapp/components/cards/big/service_info_big_card.dart';
import 'package:myparkingapp/data/service.dart';
import '../../../components/cards/big/parkingLot_info_big_card.dart';
import '../../../components/scalton/big_card_scalton.dart';
import '../../../constants.dart';

import '../../../data/parking_lot.dart';
import '../../../demo_data.dart';

/// Just for show the scalton we use [StatefulWidget]
class Body extends StatefulWidget {
  final List<ParkingLot> lots;
  final List<Service> services;
  final bool isLot;
  const Body({super.key, required this.lots, required this.services, required this.isLot});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  bool isLoading = true;
  int demoDataLength = 4;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: widget.isLot? ListView.builder(
          // while we dont have our data bydefault we show 3 scalton
          itemCount: isLoading ?demoDataLength: widget.lots.length ,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding, top:defaultPadding),
            child:
            isLoading
                ?
            const BigCardScalton()
                : ParkingLotInfoBigCard(
                    // Images are List<String>
                    press: () {}, parkingLot: widget.lots[index],
                  ),
          ),
        ):
        ListView.builder(
          // while we dont have our data bydefault we show 3 scalton
          itemCount: isLoading ? demoDataLength :widget.services.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child:
            isLoading
                ?
            const BigCardScalton()
                : ServiceInfoBigCard(
              // Images are List<String>
              press: () {}, service: widget.services[index],
            ),
          ),
        ),
      ),
    );
  }
}
