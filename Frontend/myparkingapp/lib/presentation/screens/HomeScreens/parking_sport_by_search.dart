import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/blocs/home/HomeEvent.dart';
import '../../../blocs/home/HomeBloc.dart';
import '../../../data/model/parkingLot.dart';
import 'header_text.dart';

class ParkingSpotBySearch extends StatefulWidget {
  const ParkingSpotBySearch({
    super.key,
    required this.parkingSpotsBySearch,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChange, required this.token,

  });

  final List<ParkingLot> parkingSpotsBySearch;
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChange;
  final String token;

  @override
  State<ParkingSpotBySearch> createState() => _ParkingSpotBySearchState();
}

class _ParkingSpotBySearchState extends State<ParkingSpotBySearch> {
  late List<ParkingLot> parkingLots;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    parkingLots = widget.parkingSpotsBySearch;
    currentPage = widget.currentPage;
  }

  @override
  void didUpdateWidget(covariant ParkingSpotBySearch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.parkingSpotsBySearch != widget.parkingSpotsBySearch ||
        oldWidget.currentPage != widget.currentPage) {
      setState(() {
        parkingLots = widget.parkingSpotsBySearch;
        currentPage = widget.currentPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderText(textInSpan1: 'Search', textInSpan2: 'Result'),
        SizedBox(height: Get.width / 30),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * 5,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: parkingLots.length,
            itemBuilder: (context, index) {
              var spot = parkingLots[index];
              return InkWell(
                onTap: (){
                  context.read<HomeBloc>().add(GotoDetailLotEvent(parkingLots[index], widget.token ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.width/3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "https://via.placeholder.com/150",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 50);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              spot.parkingLotName,
                              style: TextStyle(
                                fontSize: Get.width / 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_road_rounded, color: Colors.black),
                                const SizedBox(width: 5),
                                Text("${spot.rate}"),
                                SizedBox(width: Get.width / 10),
                                const Icon(Icons.monetization_on_outlined, color: Colors.black),
                                const SizedBox(width: 5),
                                Text("${spot.totalSlot}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Thanh phân trang
        Container(
          height: 60,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: currentPage > 1
                    ? () {
                  setState(() => currentPage--);
                  widget.onPageChange(currentPage);
                }
                    : null,
              ),
              Text(
                "Page $currentPage / ${widget.totalPages}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: currentPage < widget.totalPages
                    ? () {
                  setState(() => currentPage++);
                  widget.onPageChange(currentPage);
                }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
