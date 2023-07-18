import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/product_repository.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

import 'package:http/http.dart' as http;
import 'package:vin_ecommerce/util/util.dart';

class SellerAddProductPage extends StatefulWidget {
  const SellerAddProductPage({super.key});

  @override
  State<SellerAddProductPage> createState() => _SellerAddProductPageState();
}

class _SellerAddProductPageState extends State<SellerAddProductPage> {
  ProductRepository productRepo = new ProductRepository();

  XFile? myImage;
  String? imageUrl;

  List<String> categories = ['Đồ ăn', 'Thức uống', 'Nhu yếu phẩm'];
  String selectedCategory =
      ''; // Declare a variable to hold the selected category
  File?
      selectedImage; // Declare a nullable variable to hold the selected image file
  TextEditingController nameController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool checkAndShowToast(
      TextEditingController name,
      TextEditingController price,
      TextEditingController description,
      XFile? image) {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng điền đầy đủ tên sản phẩm!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (image == null) {
      Fluttertoast.showToast(
        msg: 'Vui lòng chọn hình hảnh!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (price.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng điền đầy đủ giá tiền gốc!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (!price.text.isEmpty) {
      int priceValue;

      try {
        priceValue = int.parse(price.text.toString());
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Trường giá gốc là chữ số!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }

      if (priceValue == 0) {
        Fluttertoast.showToast(
          msg: 'Trường giá gốc yêu cầu số tự nhiên lớn 0!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 1.h,
                              top: 4.h,
                              left: 4.w), // Set the desired vertical margin
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'THÊM SẢN PHẨM',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      fontFamily: 'SF Pro Text',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: 3.h, right: 4.w, left: 5.w),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'LOẠI SÁN PHẨM',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              value: categories[0],
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCategory = newValue!;
                                });
                              },
                              items: categories.map((category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Container(
                                    child: Text(category),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.5),
                                ),
                                fillColor: Color(0xffF0F5FA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a category';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'TÊN SẢN PHẨM',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.5)),

                                // border: OutlineInputBorder(),
                                // hintText: "Input Phone here",
                                fillColor: Color(0xffF0F5FA),
                                filled: true,
                              ),
                              autofocus: false,
                              textAlignVertical: TextAlignVertical.center,
                            ),
                            height: 64,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'TẢI HÌNH ẢNH',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                              // fillColor: Color(0xffECF0F4),
                              // shape: LinearBorder(),
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // Remove default padding
                                  shape: RoundedRectangleBorder(
                                    // Add a rounded shape if desired
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Colors.white),
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                myImage = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                print('${myImage?.path}');
                                setState(() {});
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 90.w,
                                  height: 20.h,
                                  child: myImage != null
                                      ? Image.file(File(myImage!.path),
                                          fit: BoxFit.cover)
                                      : Image.asset(
                                          'assets/images/add_image.png',
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 3.h),
                                      child: Container(
                                        width: 20.h,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'GIÁ GỐC',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Container(
                                        width: 20.h,
                                        child: TextField(
                                          controller: originalPriceController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange,
                                                    width: 1.5)),

                                            // border: OutlineInputBorder(),
                                            // hintText: "Input Phone here",
                                            fillColor: Color(0xffF0F5FA),
                                            filled: true,
                                          ),
                                          autofocus: false,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                        ),
                                        height: 64,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'CHI TIẾT SẢN PHẨM',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            child: TextField(
                              controller: descriptionController,
                              maxLines:
                                  null, // Set maxLines to null for multiline text area
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.5)),
                                // Adjust the vertical padding
                                fillColor: Color(0xffF0F5FA),
                                filled: true,
                              ),
                              autofocus: false,
                              textAlignVertical: TextAlignVertical.center,
                            ),
                            constraints: BoxConstraints(
                              maxHeight: 120, // Set the maximum height to 120
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                          height: 64,
                          child: ElevatedButton(
                            style: elevatedButtonStyle.copyWith(),
                            child: Text('THÊM'),
                            onPressed: () async {
                              if (!checkAndShowToast(
                                  nameController,
                                  originalPriceController,
                                  descriptionController,
                                  myImage)) {
                                return;
                              }
                              if (descriptionController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Vui lòng điền đầy đủ mô tả sản phẩm!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                                return;
                              }
                              if (myImage != null) {
                                imageUrl = await uploadImageToFireBase(myImage);
                              }
                              bool check = await productRepo.createNewProduct(
                                  selectedCategory,
                                  nameController.text.toString(),
                                  imageUrl.toString(),
                                  descriptionController.text.toString(),
                                  originalPriceController.text.toString());
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          BottomNavBar(initialIndex: 1)),
                                  (route) => false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
