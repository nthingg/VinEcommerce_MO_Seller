import 'dart:convert';

import 'package:vin_ecommerce/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  List<Order> orderList = [];
  List<dynamic> _orderList = [];
  getOrders() async {
    var url =
        "https://vinecommerce.bsite.net/api/orders/page?pageIndex=0&pageSize=10";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      _orderList = orders['items'];

      orderList = _orderList.map((e) => Order.fromJson(e)).toList();
      return orderList;
      // orderList = orders['items'];
    }
  }

  static List<Order> convert(List<dynamic> _orderList) {
    return _orderList.map((e) => Order.fromJson(e)).toList();
  }

  List<Order> getOrderList() => this.orderList;
}
