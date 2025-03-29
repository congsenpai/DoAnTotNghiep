import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/components/app_dialog.dart';

import 'package:myparkingapp/data/response/user__response.dart';import 'package:myparkingapp/data/response/service.dart';
import 'package:myparkingapp/screens/chatbot/chat_bot.dart';
import 'package:myparkingapp/screens/dashboard/dash_board_screen.dart';
import 'package:myparkingapp/screens/home/components/service_card_list.dart';
import 'package:myparkingapp/screens/search/search_screen.dart';

import '../../app/locallization/app_localizations.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../components/cards/big/big_card_image_slide.dart';
import '../../components/cards/big/parkingLot_info_big_card.dart';
import '../../components/section_title.dart';
import '../../constants.dart';
import '../../data/response/parking_lot_response.dart';
import '../../demo_data.dart';
import '../../screens/filter/filter_screen.dart';
import '../featured/featurred_screen.dart';
import 'components/parking_lot_card_list.dart';
import 'components/promotion_banner.dart';

class HomeScreen extends StatefulWidget {
  final UserResponse user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ParkingLotResponse> plots = parkingLotsDemoPage1;
  List<Service> services = [];

  
  @override
  void initState() {
    services = [
    Service(
      image: 'assets/images/AI_chatbot.png',
      name: 'Chatbot',
      description: 'training by Gemini',
      version: 1.0,
      press: () {
        // Viết logic điều hướng ở đây hoặc pass từ ngoài vào
        Get.to(ChatScreen(title: 'Gemini',));
      },
    ),
    Service(
      image: 'assets/images/budget_management.png',
      name: 'Dashboard',
      description: 'budget management',
      version: 1.0,
      press: () {
        Get.to(DashBoardScreen(user: widget.user));
      },
    ),
    ];
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Column(
          children: [
            Text(
            AppLocalizations.of(context).translate("Delivery to").toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: primaryColor),
            ),
            const Text(
              "BCP",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterScreen(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context).translate("Filter"),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>
        (builder: (context,state) {
        if(state is HomeLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
        }
        else if(state is HomeLoadedState){
          plots = state.homeLots;
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: BigCardImageSlide(images: bannerHomeScreen),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  SectionTitle(
                    title: "My Service",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeaturedScreen(lots: [], services: services, isLot: false, title: 'My Service', user: widget.user,),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  ServiceCardList(services: services,),
                  const SizedBox(height: defaultPadding),
                  // Banner
                  const PromotionBanner(),
                  const SizedBox(height: 20),
                  SectionTitle(
                    title: "Nearly Parking Lots",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeaturedScreen(lots: plots, services: [], isLot: true, title: 'Nearly Parking Lots', user: widget.user,),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ParkingLotCardList(lots: plots, user: widget.user),
                  const SizedBox(height: 16),
                  const SizedBox(height: 20),
                  SectionTitle(title: "All ParkingSlot", press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen( user: widget.user,),
                  ),
            ), ),
                  const SizedBox(height: 16),
                  // Demo list of Big Cards
                  ParkingLotList(lots: parkingLotsDemoPage1, user: widget.user)
                ],
              ),
            ),
          );
        }
        return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
      },
          listener: (context,state){
          if(state is HomeErrorState){
            return AppDialog.showErrorEvent(context, state.mess);
          }

          })
    );
  }
}
