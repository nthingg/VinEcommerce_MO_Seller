import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';

import 'package:vin_ecommerce/screens/seller_orders.dart';
import 'package:vin_ecommerce/screens/seller_orders_request.dart';
import 'package:vin_ecommerce/screens/seller_reviews.dart';

import 'package:vin_ecommerce/data/review_repository.dart';
import 'package:vin_ecommerce/models/review_model.dart';
import 'package:vin_ecommerce/data/store-staff_repository.dart';
import 'package:vin_ecommerce/models/store-staff_model.dart';
import 'package:vin_ecommerce/data/order_repository.dart';

import 'package:vin_ecommerce/styles/color.dart';
import 'package:vin_ecommerce/util/util.dart';

class SellerDashboardPage extends StatefulWidget {
  const SellerDashboardPage({super.key});

  @override
  State<SellerDashboardPage> createState() => _SellerDashboardPageState();
}

class _SellerDashboardPageState extends State<SellerDashboardPage> {
  ReviewRepository reviewRepo = new ReviewRepository();
  StoreStaffRepository staffRepo = new StoreStaffRepository();
  OrderRepository orderRepo = new OrderRepository();
  List<Review> _reviewList = [];
  StoreStaff? staff;
  int totalPending = 0;
  int totalHandled = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatas();
    // getStaff();
  }

  getDatas() async {
    var storeStaff = await staffRepo.getStaff();
    var list = await reviewRepo.getReviews();
    var pending = await orderRepo.getTotalPendingOrders();
    var done = await orderRepo.getTotalDoneOrders();
    var cancel = await orderRepo.getTotalCancelOrders();
    setState(() {
      _reviewList = list;
      staff = storeStaff;
      totalPending = pending;
      totalHandled = done + cancel;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightGrayColor,
        body: Container(
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
                            margin: EdgeInsets.only(left: 8.w),
                            width: 54.w, // Set the desired width for the Column
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    staff?.getStoreName()?.toString() ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    staff?.getName()?.toString() ?? '',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12.w),
                            child: RawMaterialButton(
                              fillColor: Color(0xffECF0F4),
                              shape: CircleBorder(),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            BottomNavBar(initialIndex: 4)));
                              },
                              child: CircleAvatar(
                                radius:
                                    24, // Set the desired radius for the circular image
                                backgroundImage: NetworkImage(
                                  staff?.getStoreAvatarUrl()?.toString() ??
                                      'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h, right: 3.w, left: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                            shape: RoundedRectangleBorder(
                              // Add a rounded shape if desired
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SellerOrdersPage()));
                        },
                        child: Container(
                          width: 40.w,
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          padding: EdgeInsets.only(
                              right: 2.h, left: 2.h, top: 1.h, bottom: 2.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  totalHandled.toString(),
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2.w),
                                child: Text(
                                  'Đơn đã xử lý',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                            shape: RoundedRectangleBorder(
                              // Add a rounded shape if desired
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SellerRequestOrdersPage()));
                        },
                        child: Container(
                          width: 40.w,
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          padding: EdgeInsets.only(
                              right: 2.h, left: 2.h, top: 1.h, bottom: 2.h),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set the desired background color
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  totalPending.toString(),
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2.w),
                                child: Text(
                                  'Đơn đến',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                margin: EdgeInsets.only(top: 4.h, right: 6.w, left: 6.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  child: Column(children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 3.h),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60.w,
                                      child: Text(
                                        'ĐÁNH GIÁ TỪ KHÁCH HÀNG',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SellerReviewsPage()),
                                        );
                                      },
                                      child: Container(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    primaryColor, // Set the desired border color
                                                width:
                                                    1.0, // Set the desired border width
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'Xem tất cả',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/star.png',
                                        fit: BoxFit.scaleDown,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          return Transform.scale(
                                            scale: 0.16.h,
                                            child: child,
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        calculateTotalRate(_reviewList)
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        'Tổng ' +
                                            _reviewList.length.toString() +
                                            ' đánh giá',
                                        style: TextStyle(
                                            color: secondaryTextColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getValidation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print("token ne`" + token!);
  }
}
