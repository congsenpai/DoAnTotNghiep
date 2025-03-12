import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/components/cards/medium/Service_info_medium_card.dart';
import 'package:myparkingapp/data/service.dart';
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
import '../../data/parking_lot.dart';
import '../../data/user.dart';
import '../../demo_data.dart';
import '../../screens/filter/filter_screen.dart';
import '../details/details_screen.dart';
import '../featured/featurred_screen.dart';
import 'components/parking_lot_card_list.dart';
import 'components/promotion_banner.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ParkingLot> plots = parkingLotsDemoPage1;

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeInitialEvent(widget.token));
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
          return Center(child:CircularProgressIndicator() ,) ;
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
                        builder: (context) => FeaturedScreen(lots: [], services: services, isLot: false,),
                      ),
                    ),
                  ),
                  ServiceCardList(services: services,),

                  const SizedBox(height: defaultPadding),
                  const SizedBox(height: 20),
                  // Banner
                  const PromotionBanner(),
                  const SizedBox(height: 20),
                  SectionTitle(
                    title: "Nearly Parking Lots",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeaturedScreen(lots: plots, services: [], isLot: true,),
                      ),
                    ),
                  ),
                  ParkingLotCardList(lots: plots),
                  const SizedBox(height: 16),
                  const SizedBox(height: 20),
                  SectionTitle(title: "All ParkingSlot", press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(token: widget.token,),
                  ),
            ), ),
                  const SizedBox(height: 16),
                  // Demo list of Big Cards
                  ParkingLotList(lots: parkingLotsDemoPage1)
                ],
              ),
            ),
          );
        }
        return Center(child:CircularProgressIndicator() ,) ;
      },
          listener: (context,state){
          if(state is HomeErrorState){
            print(state.mess);
          }

          })
    );
  }
}
