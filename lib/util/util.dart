import 'package:vin_ecommerce/models/review_model.dart';

double calculateTotalRate(List<Review> reviewList) {
  double totalRate = 0;

  for (var review in reviewList) {
    totalRate += review.getRate()!.toDouble();
  }

  return totalRate / reviewList.length;
}
