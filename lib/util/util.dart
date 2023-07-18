import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vin_ecommerce/models/review_model.dart';
import 'dart:io';

double calculateTotalRate(List<Review> reviewList) {
  double totalRate = 0;

  for (var review in reviewList) {
    totalRate += review.getRate()!.toDouble();
  }

  return totalRate / reviewList.length;
}

Future<String> uploadImageToFireBase(XFile? myImage) async {
  String imageUrl = '';

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  //Step 2: Upload image to firebase storage
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('images');

  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

  //Handle error/success
  try {
    //Store the file
    await referenceImageToUpload.putFile(File(myImage!.path));
    //Success
    imageUrl = await referenceImageToUpload.getDownloadURL();
    print('imageUrl: ' + imageUrl);
  } catch (error) {
    //Error occur
  }

  return imageUrl;
}

List<String> categories = ['Đồ ăn', 'Thức uống', 'Nhu yếu phẩm'];

int getIndexByCategory(String category) {
  for (int i = 0; i < categories.length; i++) {
    if (categories[i] == category) {
      return i;
    }
  }
  return -1; // Return -1 if the category is not found
}
