import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/product_repository.dart';
import 'package:vin_ecommerce/models/product_model.dart';
import 'package:vin_ecommerce/screens/seller_storage.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';
import 'package:vin_ecommerce/styles/square_title.dart';

import 'package:http/http.dart' as http;

class SellerProductInfoPage extends StatefulWidget {
  final int productId;

  const SellerProductInfoPage({Key? key, required this.productId})
      : super(key: key);

  @override
  State<SellerProductInfoPage> createState() => _SellerProductInfoPageState();
}

class _SellerProductInfoPageState extends State<SellerProductInfoPage> {
  String salePrice = '100.000';

  ProductRepository productRepo = new ProductRepository();
  Product? _product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct(6);
  }

  getProduct(int productId) async {
    var product = await productRepo.getProductById(productId);
    setState(() {
      _product = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.h), // Set the desired vertical margin
                          child: Row(
                            children: [
                              Container(
                                child: RawMaterialButton(
                                  fillColor: Color(0xffECF0F4),
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNavBar(
                                                initialIndex: 1,
                                              )),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/back.png',
                                    scale: 1,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CHI TIẾT SẢN PHẨM',
                                    style: TextStyle(
                                      fontSize: 16,
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
                    width: 340, // Set the desired width
                    height: 200, // Set the desired height
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _product?.getImageUrl()?.toString() ??
                            'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png',
                        scale: 1,
                        fit: BoxFit.cover, // Set the desired BoxFit property
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 3.w, left: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _product?.getName()?.toString() ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF Pro Text',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 6.w, left: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8, right: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              color: pendingBackgroundColor,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Text(
                            _product?.getCategoryName()?.toString() ?? '',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 6.w, left: 8.w),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4.h, right: 8),
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: Text(
                            'GIÁ TIỀN',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        if (_product?.getDiscountPrice() == null)
                          Container(
                            margin: EdgeInsets.only(top: 4.h, right: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Text(
                              (_product?.getOriginalPrice()?.toString() ?? '') +
                                  ' VND',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (_product?.getDiscountPrice() != null)
                          Container(
                            margin: EdgeInsets.only(top: 4.h, right: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Text(
                              (_product?.getOriginalPrice()?.toString() ?? '') +
                                  ' VND',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        if (_product?.getDiscountPrice() != null)
                          Container(
                            margin: EdgeInsets.only(top: 4.h),
                            child: Text(
                              (_product?.getDiscountPrice()?.toString() ?? '') +
                                  ' VND',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 4.h),
                    child: Text(
                      'THÔNG TIN',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                        top: 1.h, left: 8.w, right: 8.w, bottom: 3.h),
                    child: Text(
                      _product?.getDescription()?.toString() ?? '',
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void getValidation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print("token ne`" + token!);
  }
}
