import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vin_ecommerce/screens/home_screen.dart';
import 'package:vin_ecommerce/screens/notification_screen.dart';
import 'package:vin_ecommerce/screens/add_product_screen.dart';
import 'package:vin_ecommerce/screens/order_list_screen.dart';
import 'package:vin_ecommerce/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'VinEcom',
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _items = const [
    Icon(Icons.home, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.add_circle_outline_rounded, size: 30),
    Icon(Icons.notifications, size: 30),
    Icon(Icons.person, size: 30)
  ];

  final _screens = const [
    HomeScreen(),
    OrderListScreen(),
    AddProductScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Colors.orange.shade500,
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
