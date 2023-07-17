import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_ecommerce/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:vin_ecommerce/constants/apiclient.dart';
import 'package:vin_ecommerce/services/product_service.dart';

class ProductRepository {
  List<Product> productList = [];
  List<dynamic> _productList = [];
  Product? product;

  Future<List<Product>> getProductsByStoreId(int storeId) async {
    var url = apiClient +
        PRODUCT +
        '/page?StoreId=' +
        storeId.toString() +
        '&pageIndex=0&pageSize=1000';

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var products = json.decode(response.body);
      _productList = products['items'];

      productList = _productList.map((e) => Product.fromJson(e)).toList();
      return productList;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  Future<Product> getProductById(int productId) async {
    var url = apiClient + PRODUCT + '/' + productId.toString();

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      product = Product.fromJson(jsonBody);
      return product!;
    } else {
      throw Exception(
          'Failed to fetch review. Error code: ${response.statusCode}');
    }
  }
}
