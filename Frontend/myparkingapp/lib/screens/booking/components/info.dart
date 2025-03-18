import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/parking_lot.dart';

import '../../../components/vehicle_type_list.dart';
import '../../../constants.dart';
import '../../../data/parking_slots.dart';

class Info extends StatelessWidget {
  final ParkingLot lot;
  final Slot slot;

  const Info({
    super.key, required this.lot, required this.slot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.33,
          child: Image.asset(
            lot.images[0].url,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${lot.parkingLotName}    -    ${slot.slotName}",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                lot.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "${AppLocalizations.of(context).translate("CostByMonth: ")}:${slot.pricePerMonth} / VNĐ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "${AppLocalizations.of(context).translate("CostByHour: ")}:${slot.pricePerHour} / VNĐ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
