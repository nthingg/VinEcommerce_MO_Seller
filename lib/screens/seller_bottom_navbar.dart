import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:vin_ecommerce/screens/seller_dashboard.dart';
import 'package:vin_ecommerce/screens/seller_product_add.dart';
import 'package:vin_ecommerce/screens/seller_profile.dart';
import 'package:vin_ecommerce/screens/seller_notifications.dart';
import 'package:vin_ecommerce/screens/seller_storage.dart';
import 'package:vin_ecommerce/styles/color.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final _items = const [
    Icon(Icons.home, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.add_circle_outline_rounded, size: 30),
    Icon(Icons.notifications, size: 30),
    Icon(Icons.person, size: 30)
  ];

  final _screens = const [
    SellerDashboardPage(),
    SellerStoragePage(),
    SellerAddProductPage(),
    SellerNotificationsPage(),
    SellerProfilePage()
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: primaryColor,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.green,
          items: _items,
          index: _currentIndex,
          height: 50,
          animationCurve: Curves.decelerate,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
      ));
}
