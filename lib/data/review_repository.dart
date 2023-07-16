import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_ecommerce/models/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:vin_ecommerce/constants/apiclient.dart';
import 'package:vin_ecommerce/services/storeService.dart';

class ReviewRepository {
  List<Review> reviewList = [];
  List<dynamic> _reviewList = [];

  Future<List<Review>> getReviews() async {
    var url = apiClient + getStoreReviews;

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      _reviewList = json.decode(response.body);

      reviewList = _reviewList.map((e) => Review.fromJson(e)).toList();
      return reviewList;
    } else {
      throw Exception(
          'Failed to fetch orders. Error code: ${response.statusCode}');
    }
  }

  static List<Review> convert(List<dynamic> _reviewList) {
    return _reviewList.map((e) => Review.fromJson(e)).toList();
  }

  List<Review> getReviewList() => this.reviewList;
}
