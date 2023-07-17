import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_ecommerce/models/order_detail_model.dart';
import 'package:vin_ecommerce/models/order_spec_model.dart';
import 'package:http/http.dart' as http;
import 'package:vin_ecommerce/constants/apiclient.dart';
import 'package:vin_ecommerce/services/order_service.dart';

class OrderDetailRepository {
  List<OrderDetail> orderDetailList = [];
  List<dynamic> _orderDetailList = [];
  OrderSpec? spec;

  Future<List<OrderDetail>> getOrderDetailsById(int orderId) async {
    var url = apiClient + ORDER + '/' + orderId.toString();

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orderDetails = json.decode(response.body);
      _orderDetailList = orderDetails['details'];

      orderDetailList =
          _orderDetailList.map((e) => OrderDetail.fromJson(e)).toList();
      return orderDetailList;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<OrderSpec> getOrderSpec(int orderId) async {
    var url = apiClient + ORDER + '/' + orderId.toString();

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      spec = OrderSpec.fromJson(jsonBody);
      return spec!;
    } else {
      throw Exception(
          'Failed to fetch review. Error code: ${response.statusCode}');
    }
  }
}
