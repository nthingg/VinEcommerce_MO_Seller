// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/routes/route_generator.dart';

import 'package:vin_ecommerce/screens/sign_in_page.dart';
import 'package:vin_ecommerce/screens/seller_orders.dart';
import 'package:vin_ecommerce/screens/seller_order_details_request.dart';
import 'package:vin_ecommerce/screens/seller_order_details.dart';
import 'package:vin_ecommerce/screens/seller_orders_request.dart';
import 'package:vin_ecommerce/screens/seller_notifications.dart';
import 'package:vin_ecommerce/screens/seller_storage.dart';
import 'package:vin_ecommerce/screens/seller_reviews.dart';
import 'package:vin_ecommerce/screens/seller_profile.dart';
import 'package:vin_ecommerce/screens/seller_dashboard.dart';
import 'package:vin_ecommerce/screens/seller_product_add.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:vin_ecommerce/screens/seller_product_info.dart';
import 'package:vin_ecommerce/screens/sign_up_page.dart';
import 'package:vin_ecommerce/screens/seller_personal_info.dart';

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
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'VinEcom',
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        onGenerateRoute: RouteGenerator.generatorRoute,
      );
    });
  }
}
