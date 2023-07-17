import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_ecommerce/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:vin_ecommerce/constants/apiclient.dart';
import 'package:vin_ecommerce/services/order_service.dart';

class OrderRepository {
  List<Order> orderList = [];
  List<dynamic> _orderList = [];

  Future<List<Order>> getDoneOrders() async {
    var url = apiClient + getDoneOrder;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      _orderList = orders['items'];

      orderList = _orderList.map((e) => Order.fromJson(e)).toList();
      return orderList;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<List<Order>> getCancelOrders() async {
    var url = apiClient + getCancelOrder;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      _orderList = orders['items'];

      orderList = _orderList.map((e) => Order.fromJson(e)).toList();
      return orderList;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<List<Order>> getPendingOrders() async {
    var url = apiClient + getPendingOrder;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      _orderList = orders['items'];

      orderList = _orderList.map((e) => Order.fromJson(e)).toList();
      return orderList;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<int> getTotalDoneOrders() async {
    var url = apiClient + getTotalDoneOrder;
    int doneOrders = 0;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      doneOrders = orders['totalItemsCount'];

      return doneOrders;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<int> getTotalCancelOrders() async {
    var url = apiClient + getTotalCancelOrder;
    int cancelOrders = 0;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      cancelOrders = orders['totalItemsCount'];

      return cancelOrders;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<int> getTotalPendingOrders() async {
    var url = apiClient + getTotalPendingOrder;
    int doneOrders = 0;
    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var orders = json.decode(response.body);
      doneOrders = orders['totalItemsCount'];

      return doneOrders;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }
}
