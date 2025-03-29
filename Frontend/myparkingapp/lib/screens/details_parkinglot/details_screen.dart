import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_bloc.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_state.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

import '../../bloc/lot/lot_detail_event.dart';
import '../../components/app_dialog.dart';
import '../../constants.dart';
import 'components/featured_items.dart';
import 'components/iteams.dart';
import 'components/lot_info.dart';

class DetailsScreen extends StatefulWidget {
  final UserResponse user;
  final ParkingLotResponse parkingLot;
  const DetailsScreen({super.key, required this.parkingLot, required this.user});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  List<String> floorNames = [];

  DataOnFloor dataOnFloor = DataOnFloor("", [], []);

  @override
  void initState() {
    // TODO: implement initState
    context.read<LotDetailBloc>().add(LotDetailScreenInitialEvent(widget.parkingLot));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/share.svg"),
            onPressed: () {

            },
          ),
        ],
      ),
      body:BlocConsumer<LotDetailBloc,LotDetailState>
        (builder: (context,state){
          if(state is LoadingLotDetailState){
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
          }
          else if(state is LoadedLotDetailState){

            floorNames = state.dataOnFloor.floorNames;
            dataOnFloor = state.dataOnFloor;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding / 2),
                    ParkingLotInfo(lot: widget.parkingLot,),
                    SizedBox(height: defaultPadding),
                    FeaturedItems(images: widget.parkingLot.images,),
                    DefaultTabController(
                      length: floorNames.length,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            unselectedLabelColor: titleColor,
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                            onTap: (index) {
                              // Lấy tên tầng dựa vào chỉ số tab được bấm
                              String selectedFloorName = floorNames[index];
                              // Gửi event kèm tên tầng
                              context.read<LotDetailBloc>().add(
                                LoadListLotsEvent( selectedFloorName, widget.parkingLot),
                              );
                            },
                            tabs: floorNames.map((name) => Tab(text: name)).toList(), // Tạo tab cho mỗi tầng
                          ),
                          // Có thể thêm TabBarView ở đây nếu muốn hiển thị nội dung tương ứng với từng tab
                        ],
                      ),
                    ),
                    Items(slots: dataOnFloor.lots, lot: widget.parkingLot, user: widget.user,),
                  ],
                ),
              ),
            );
          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
      }, listener: (context,state){
          if(state is LotDetailErrorScreen){
            return AppDialog.showErrorEvent(context, state.mess);
          }
      })




    );
  }
}
