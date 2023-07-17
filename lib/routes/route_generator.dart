import 'package:flutter/material.dart';
import 'package:vin_ecommerce/main.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:vin_ecommerce/screens/seller_order_details.dart';
import 'package:vin_ecommerce/screens/seller_order_details_request.dart';
import 'package:vin_ecommerce/screens/seller_product_info.dart';
import 'package:vin_ecommerce/screens/seller_storage.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    // Getting arguments passed while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainApp());
      case '/storage':
        return MaterialPageRoute(
          builder: (_) => BottomNavBar(initialIndex: 1),
        );
      case '/orderRequestDetails':
        if (args != null && args is Map<String, dynamic>) {
          final orderId = args['orderId'] as int?;
          if (orderId != null) {
            return MaterialPageRoute(
              builder: (_) => SellerRequestOrderDetailsPage(orderId: orderId),
            );
          }
        }
        return _errorRoute();
      case '/orderDetails':
        if (args != null && args is Map<String, dynamic>) {
          final orderId = args['orderId'] as int?;
          if (orderId != null) {
            return MaterialPageRoute(
              builder: (_) => SellerOrderDetailsPage(orderId: orderId),
            );
          }
        }
        return _errorRoute();
      case '/productInfo':
        if (args != null && args is Map<String, dynamic>) {
          final productId = args['productId'] as int?;
          final orderId = args['orderId'] as int?;
          final fatherRoute = args['fatherRoute']?.toString();
          if (productId != null && orderId != null && fatherRoute != null) {
            return MaterialPageRoute(
              builder: (_) => SellerProductInfoPage(
                productId: productId,
                orderId: orderId,
                fatherRoute: fatherRoute,
              ),
            );
          }
        }
        return _errorRoute();
      default:
        return MaterialPageRoute(
          builder: (_) => BottomNavBar(initialIndex: 0),
        );
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid arguments passed!'),
        ),
      ),
    );
  }
}
