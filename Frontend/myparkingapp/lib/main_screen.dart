import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import 'data/parking_lot.dart';
import 'screens/home/home_screen.dart';
import 'screens/orderDetails/order_details_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  final List<ParkingLot> lots;
  const MainScreen({super.key, required this.lots});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Bydefault first one is selected
  int _selectedIndex = 0;
  List<ParkingLot> parkinglots = parkingLotsDemoPage1;

  // List of nav items
  final List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "Home"},
    {"icon": "assets/icons/search.svg", "title": "Search"},
    {"icon": "assets/icons/order.svg", "title": "Orders"},
    {"icon": "assets/icons/profile.svg", "title": "Profile"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkinglots = widget.lots;

  }
  final List<Widget> _screens = [
    HomeScreen(token: '',),
    SearchScreen(token: '',),
    const OrderDetailsScreen(),
    const ProfileScreen(),
  ];

// Screens


  @override
  Widget build(BuildContext context) {
    /// If you set your home screen as first screen make sure call [SizeConfig().init(context)]

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CupertinoTabBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        activeColor: primaryColor,
        inactiveColor: bodyTextColor,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _navitems[index]["icon"],
              height: 30,
              width: 30,
              colorFilter: ColorFilter.mode(
                  index == _selectedIndex ? primaryColor : bodyTextColor,
                  BlendMode.srcIn),
            ),
            label: _navitems[index]["title"],
          ),
        ),
      ),
    );
  }
}
