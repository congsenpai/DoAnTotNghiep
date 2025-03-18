import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/parking_lot.dart';
import '../../../components/vehicle_type_list.dart';
import '../../../components/rating_with_counter.dart';
import '../../../constants.dart';

class ParkingLotInfo extends StatelessWidget {
  final ParkingLot lot;
  const ParkingLotInfo({
    super.key, required this.lot,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).translate(lot.parkingLotName),
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
          ),
          const SizedBox(height: defaultPadding / 2),
          Text(
            AppLocalizations.of(context).translate(lot.description),
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
          ),
          const SizedBox(height: defaultPadding / 2),
          RatingWithCounter(rating: lot.rate, numOfRating: 200),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              DeliveryInfo(
                iconSrc: "assets/icons/delivery.svg",
                text: AppLocalizations.of(context).translate("Slots total"),
                subText: lot.totalSlot.toString(),
              ),
              const SizedBox(width: defaultPadding),
              DeliveryInfo(
                iconSrc: "assets/icons/clock.svg",
                text: AppLocalizations.of(context).translate("Status"),
                subText: lot.status.name.toUpperCase(),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(AppLocalizations.of(context).translate("Advise")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
    required this.iconSrc,
    required this.text,
    required this.subText,
  });

  final String iconSrc, text, subText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(
            primaryColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            text: "$text\n",
            style: Theme.of(context).textTheme.labelLarge,
            children: [
              TextSpan(
                text: subText,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ],
    );
  }
}
