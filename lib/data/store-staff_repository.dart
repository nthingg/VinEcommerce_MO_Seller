import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vin_ecommerce/constants/apiclient.dart';
import 'package:vin_ecommerce/models/store-staff_model.dart';
import 'package:vin_ecommerce/services/store-staff_service.dart';

class StoreStaffRepository {
  StoreStaff? storeStaff;

  Future<StoreStaff> getStaff() async {
    var url = apiClient + getStaffInfo;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      storeStaff = StoreStaff.fromJson(jsonBody);
      return storeStaff!;
    } else {
      throw Exception(
          'Failed to fetch review. Error code: ${response.statusCode}');
    }
  }

  Future<bool> updateProfile(
      String name, String? avatarUrl, String email) async {
    try {
      var body = {"name": name, "avatarUrl": avatarUrl, "email": email};

      // Retrieve token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var headers = {
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.post(
          Uri.parse(apiClient + getStaffInfo),
          headers: headers,
          body: json.encode(body));
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
