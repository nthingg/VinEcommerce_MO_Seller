import 'package:vin_ecommerce/constants/apiclient.dart';
import 'package:vin_ecommerce/models/store_model.dart';
import 'package:vin_ecommerce/services/store_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreRepository {
  Store? store;

  Future<Store> getStoreById(String storeId) async {
    var url = apiClient + STORE + '/' + storeId;

    // Retrieve token from SharedPreferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');

    // var headers = {
    //   'Authorization': 'Bearer $token',
    // };

    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      store = Store.fromJson(jsonBody);
      return store!;
    } else {
      throw Exception(
          'Failed to fetch review. Error code: ${response.statusCode}');
    }
  }
}
