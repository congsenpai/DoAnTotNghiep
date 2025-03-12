import 'package:flutter/material.dart';
import 'package:myparkingapp/data/service.dart';

import '../../data/parking_lot.dart';
import 'components/body.dart';

class FeaturedScreen extends StatelessWidget {
  final List<ParkingLot> lots;
  final List<Service> services;
  final bool isLot;
  const FeaturedScreen({super.key, required this.lots, required this.services, required this.isLot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Featured Partners"),
      ),
      body: Body(lots: lots, services: services, isLot: isLot,),
    );
  }
}
