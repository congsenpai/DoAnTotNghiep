// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/model/image.dart';
import 'package:myparkingapp/data/model/parkingLot.dart';
import 'package:myparkingapp/data/model/user.dart';
import '../../../blocs/Lot/LotBloc.dart';
import '../../../blocs/Lot/LotEvent.dart';
import '../../../blocs/Lot/LotState.dart';
import '../../widgets/Starwidget.dart';
import '../../widgets/classInitial.dart';
import '../parkingSlotScreen/parking_slot_screen.dart';

class ParkingSpotScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final bool isMonthly;
  final ParkingLot data;
  final User user;
  final List<Images> image;
  final String token;

  const ParkingSpotScreen({super.key,
    required this.data,
    required this.user,
    required this.isMonthly, required this.image, required this.onLanguageChange, required this.token});

  @override
  State<ParkingSpotScreen> createState() => _ParkingSpotScreenState();
}

class _ParkingSpotScreenState extends State<ParkingSpotScreen> {
  final String Language = 'vi';
  int _star = 4;
  ParkingLot parkingLot = selectedParkingLotInitial;
  Images _currentImagePath = selectedImagesInitial;
  List<Images> _imagePaths = [];
  // final MapWidget _mapWidget = MapWidget(endPoint: LatLng(21.0285, 105.8542));

  @override
  void initState() {

    super.initState();
    parkingLot = widget.data;
    _currentImagePath = widget.image[0];
    _imagePaths = widget.image;
    _star = parkingLot.rate.toInt() ;
  }

// Future<LatLng?> _getSpotPosition() async {
//   if (parkingLot) {
//     LatLng latLng =
//     LatLng(parkingLot.location.latitude, parkingLot!.location.longitude);
//     return latLng;
//   }
//   return null;
// }


@override
Widget build(BuildContext context) {
  return BlocConsumer<LotBloc, LotState>(
      builder: (context, state) {
        if (state is LotLoadedState) {
          _currentImagePath = state.image;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {

                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ảnh chính
                  Container(
                    height: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://drive.google.com/uc?export=view&id=$_currentImagePath",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Ảnh con
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _imagePaths.map((image) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<LotBloc>()
                                .add(ChangeImageEvent(image));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _currentImagePath == image
                                    ? Colors.grey
                                    : Colors.transparent,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://drive.google.com/uc?export=view&id=$image",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Widget chi tiết thông tin
                  buildParkingDetails(),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is GotoSlotScreenState){
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => ParkingSlotScreen(lists: state.listSlot, IsMonthly: false, user: widget.user, token: state.token,)));

        }
      });
}

// Hàm Widget chứa các chi tiết thông tin
Widget buildParkingDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        parkingLot.parkingLotName,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      StarWidget(startNumber: _star, evaluateNumber: 100000),
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(Icons.location_on, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          const Text("1.3km"),
          const SizedBox(width: 16),
          const Icon(Icons.attach_money, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
              '${parkingLot.totalSlot} ${AppLocalizations.of(context).translate(
                  'Slot')}'),
        ],
      ),
      const SizedBox(height: 16),
      Text(AppLocalizations.of(context).translate('Description'),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        parkingLot.description,
        style: const TextStyle(color: Colors.grey),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Icon(Icons.security, color: Colors.blue),
              Text(AppLocalizations.of(context).translate('Description')),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.electrical_services, color: Colors.blue),
              Text(AppLocalizations.of(context).translate('Description')),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.wc, color: Colors.blue),
              Text(AppLocalizations.of(context).translate('Description')),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text(
        "Location",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      // FutureBuilder<LatLng?>(
      //   future: _getSpotPosition(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasData && snapshot.data != null) {
      //       return Container(
      //         height: 200,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(12),
      //           color: Colors.grey[300],
      //         ),
      //         child: _mapWidget.buildBasicMap(snapshot.data!),
      //       );
      //     } else {
      //       return const Text(
      //         "Unable to fetch location.",
      //         style: TextStyle(color: Colors.red),
      //       );
      //     }
      //   },
      // ),
      const Text(
        "Open Map",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<LotBloc>().add(GotoSlotScreenEvent(widget.token, widget.data));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Explore Parking Spots",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal)),
        ),
      ),
    ],
  );
}}
