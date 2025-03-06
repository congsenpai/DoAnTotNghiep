// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/presentation/screens/HomeScreens/parking_sport_by_search.dart';
import 'package:myparkingapp/presentation/screens/DetailParkingSpotScreen/DetailParkingSpotScreent.dart';
import '../../../blocs/home/HomeBloc.dart';
import '../../../blocs/home/HomeEvent.dart';
import '../../../blocs/home/HomeState.dart';
import '../../../data/model/discount.dart';
import '../../../data/model/image.dart';
import '../../../data/model/parkingLot.dart';
import '../../../data/model/user.dart';
import '../../widgets/footer_widget.dart';
import 'discountList.dart';


class HomeScreen extends StatefulWidget {
  final User user; // Thêm biến này để lưu trữ thông tin user
  final String token;
  final Function(Locale) onLanguageChange;

  const HomeScreen(
      {super.key,
      required this.user,
      required this.token,
      required this.onLanguageChange}); // Sử dụng this.user để truy cập trong lớp State
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ParkingLot> parkingLots = [];
  List<Discount> discounts = [];
  int pageCurrent = 0;
  int pageAmount = 1;
  String currentText = '';


  @override
  void initState() {

    super.initState();
    _searchController.addListener(() {
      if (kDebugMode) {
        print("Search text: ${_searchController.text}");
      }
      // Bạn có thể thực hiện bất kỳ hành động nào khi giá trị thay đổi
    });
  }

  void updateLotList(int page){
    context.read<HomeBloc>().add(HomeLoadParkingLotEvent(page,currentText,widget.token));
    setState(() {
      pageCurrent = page;
    });
  }


  @override
  void dispose() {
    // Hủy controller khi không còn cần thiết
    _searchController.dispose();
    super.dispose();
    // BackButtonInterceptor.remove(isLogout);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
      if (state is HomeScreenLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HomeStandardState) {
        parkingLots = state.lots;
        discounts = state.discounts;
      }
      else if(state is HomeLoadedState){
        parkingLots = state.parkingLots;
        pageCurrent = state.page;
        pageAmount = state.pageAmount;
      }
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: Get.width/2.2, // Chiều cao khi mở rộng
                floating: false, // Không hiển thị lại khi cuộn lên nhanh
                pinned: false, // Không giữ lại khi cuộn lên
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: Get.width / 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.width / 40),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      minRadius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(width: Get.width / 40),
                                    Text(
                                      widget.user.username,
                                      style: const TextStyle(
                                          color: Color(0xFFFAF9F6), fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.width / 15),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Get Your\n",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.white.withOpacity(0.5),
                                              offset: const Offset(2, 2),
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Secure Park",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.white.withOpacity(0.5),
                                              offset: const Offset(2, 2),
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/images/AnhAppbar.png",
                            width: Get.width / 2.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true, // Giữ lại thanh tìm kiếm khi cuộn
                delegate: _SearchBarDelegate(_searchController),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    color: const Color.fromRGBO(230, 230, 230, 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.width / 15),
                        DiscountListWidget(discounts: demoDiscounts),
                        SizedBox(height: Get.width / 15),
                        ParkingSpotBySearch(
                          parkingSpotsBySearch: parkingLotList,
                          currentPage: pageCurrent,
                          totalPages: pageAmount,
                          onPageChange: updateLotList, token: widget.token,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: footerWidget(user: widget.user, token: widget.token, onLanguageChange: widget.onLanguageChange,
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is HomeErrorState) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content: Text(AppLocalizations.of(context).translate(state.message)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
      else if(state is GotoDetailLotScreenState){
        ParkingLot parkingLot = state.parkingLot;
        List<Images> image = state.image;
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) =>
              ParkingSpotScreen(data: parkingLot,
                  user: widget.user, isMonthly: false, image: image, onLanguageChange: widget.onLanguageChange, token: widget.token)));
      }
    });
  }
}
class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;
  _SearchBarDelegate(this.controller);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search by name or city area',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) => false;
}

