import 'package:flutter/material.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/order_repository.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:vin_ecommerce/screens/seller_order_details.dart';
import 'package:vin_ecommerce/styles/color.dart';

import '../../models/order_model.dart';

class SellerOrdersPage extends StatefulWidget {
  const SellerOrdersPage({super.key});
  @override
  State<StatefulWidget> createState() => _SellerOrdersPageState();
}

class _SellerOrdersPageState extends State<SellerOrdersPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  OrderRepository orderRepo = new OrderRepository();
  List<Order> _doneOrderList = [];
  List<Order> _cancelOrderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoneOrders();
    getCancelOrders();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  getDoneOrders() async {
    var list = await orderRepo.getDoneOrders();
    setState(() {
      _doneOrderList = list;
    });
  }

  getCancelOrders() async {
    var list = await orderRepo.getCancelOrders();
    setState(() {
      _cancelOrderList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final storage = new FlutterSecureStorage();
    // Future<String?> token = storage.read(key: 'token');
    // Object token1 = token != null? token: "";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appbar(),
        body: Container(
          color: Colors.grey[300],
          child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _doneOrderList.length,
                  itemBuilder: (context, index) {
                    Order order = _doneOrderList[index];
                    int orderId = _doneOrderList[index].Id != null
                        ? _doneOrderList[index].Id!
                        : 0;

                    // main();

                    return Container(
                      margin: EdgeInsets.only(
                          top: 12, bottom: 12, left: 12, right: 12),
                      child: ElevatedButton(
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
                                builder: (context) => SellerOrderDetailsPage(
                                      orderId: orderId,
                                    )),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5.w),
                          height: 28.h,
                          child: Column(children: [
                            Row(
                              children: [
                                Container(
                                  width: 56.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 12),
                                        child: Row(
                                          children: [
                                            Text(
                                              'ĐƠN #',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              order.getId().toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 7),
                                              decoration: BoxDecoration(
                                                  color:
                                                      deliveredBackgroundColor,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(14))),
                                              child: Text(
                                                order.getStatus().toString(),
                                                style: TextStyle(
                                                    color:
                                                        deliveredForegroundColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 25, top: 2.h),
                                        child: Text(
                                          'FROM',
                                          style: TextStyle(
                                              color: secondaryTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/from_icon.png'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  order
                                                      .getStoreBuildingName()
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 25, top: 2.h),
                                        child: Text(
                                          'TO',
                                          style: TextStyle(
                                              color: secondaryTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/to_icon.png'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  order
                                                      .getCustomerBuildingName()
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Customer',
                                              style: TextStyle(
                                                  color: secondaryTextColor),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              order
                                                  .getCustomerName()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Text(
                                        order.getTotal().toString() + ' VND',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    );
                  }),
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _cancelOrderList.length,
                  itemBuilder: (context, index) {
                    Order order = _cancelOrderList[index];
                    int orderId = _cancelOrderList[index].Id != null
                        ? _cancelOrderList[index].Id!
                        : 0;

                    // main();

                    return Container(
                      margin: EdgeInsets.only(
                          top: 12, bottom: 12, left: 12, right: 12),
                      child: ElevatedButton(
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
                              builder: (context) => SellerOrderDetailsPage(
                                orderId: orderId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5.w),
                          height: 28.h,
                          child: Column(children: [
                            Row(
                              children: [
                                Container(
                                  width: 56.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 12),
                                        child: Row(
                                          children: [
                                            Text(
                                              'ĐƠN #',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              order.getId().toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 7),
                                              decoration: BoxDecoration(
                                                  color: redColorBackground,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(14))),
                                              child: Text(
                                                order.getStatus().toString(),
                                                style:
                                                    TextStyle(color: redColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 25, top: 2.h),
                                        child: Text(
                                          'FROM',
                                          style: TextStyle(
                                              color: secondaryTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/from_icon.png'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  order
                                                      .getStoreBuildingName()
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 25, top: 2.h),
                                        child: Text(
                                          'TO',
                                          style: TextStyle(
                                              color: secondaryTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/to_icon.png'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  order
                                                      .getCustomerBuildingName()
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Customer',
                                              style: TextStyle(
                                                  color: secondaryTextColor),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              order
                                                  .getCustomerName()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        order.getTotal().toString() + ' VND',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    );
                  }),
            ],
            // child: Text(token1.toString()),
          ),
        ),
      ),
    );
  }

  PreferredSize _appbar() {
    return PreferredSize(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topBar(),
            _tabBar(),
          ],
        )),
        preferredSize: Size.fromHeight(18.h));
  }

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 1.w),
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
                      initialIndex: 0,
                    ),
                  ),
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
                'ĐƠN ĐÃ XỬ LÝ',
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
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TabBar(
          controller: tabController,
          indicatorColor: primaryColor,
          labelColor: primaryColor,
          unselectedLabelColor: secondaryTextColor,
          tabs: const [
            Tab(
              text: 'Hoàn thành',
            ),
            Tab(
              text: 'Đã huỷ',
            )
          ]),
    );
  }
}
