import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/screens/seller_product_info.dart';
import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';
import 'package:vin_ecommerce/styles/square_title.dart';
import 'package:vin_ecommerce/screens/seller_reviews.dart';
import 'package:vin_ecommerce/screens/seller_personal_info.dart';

import 'package:http/http.dart' as http;

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({super.key});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passenable = true;
  bool isRemember = false;
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
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
                    height: 28.h,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24))),
                    width: size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h), // Set the desired vertical margin
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CircleAvatar(
                              radius: 7
                                  .h, // Set the desired radius for the circular image
                              backgroundImage:
                                  AssetImage('assets/images/vinshop.png'),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: 3.h), // Set the desired vertical margin
                          child: Text(
                            'Nhà Hàng Ngọc Thịnh',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'SF Pro Text',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 5.w, left: 4.w),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SellerPersonalInfoPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.6.h),
                              decoration: BoxDecoration(
                                color:
                                    lightGrayColor, // Set the desired background color
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/personal_info_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 56.w,
                                    child: Text(
                                      'Thông tin nhân viên',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.5
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/arrow_right_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SellerProductInfoPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.6.h),
                              decoration: BoxDecoration(
                                color:
                                    lightGrayColor, // Set the desired background color
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/settings_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 56.w,
                                    child: Text(
                                      'Cài đặt',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.5
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/arrow_right_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 5.w, left: 4.w),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SellerProductInfoPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.6.h),
                              decoration: BoxDecoration(
                                color:
                                    lightGrayColor, // Set the desired background color
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/orders_num_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 56.w,
                                    child: Text(
                                      'Số lượng đơn hàng',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.5
                                            .w), // Set the desired margin value
                                    child: Text(
                                      '12',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SellerReviewsPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.6.h),
                              decoration: BoxDecoration(
                                color:
                                    lightGrayColor, // Set the desired background color
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/reviews_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 56.w,
                                    child: Text(
                                      'Đánh giá',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.5
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/arrow_right_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 5.w, left: 4.w),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SellerProductInfoPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.6.h),
                              decoration: BoxDecoration(
                                color:
                                    lightGrayColor, // Set the desired background color
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/logout_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 56.w,
                                    child: Text(
                                      'Đăng xuất',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.5
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/arrow_right_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
