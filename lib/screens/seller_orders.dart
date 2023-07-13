import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/order_repository.dart';
import 'package:vin_ecommerce/main.dart';
import 'package:vin_ecommerce/screens/seller_order_details.dart';
import 'package:vin_ecommerce/styles/app_assets.dart';
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
  List<Order> _orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  getOrders() async {
    var list = await orderRepo.getOrders();
    setState(() {
      _orderList = list;
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
        body: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _orderList.length,
                itemBuilder: (context, index) {
                  int orderId =
                      _orderList[index].Id != null ? _orderList[index].Id! : 0;

                  main();

                  return Container(
                    margin: EdgeInsets.only(top: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerOrderDetailsPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5.w),
                        height: 15.h,
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                width: 56.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            'ĐƠN #',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            orderId.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 12),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 7),
                                            decoration: BoxDecoration(
                                                color: deliveredBackgroundColor,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Text(
                                              'Hoàn thành',
                                              style: TextStyle(
                                                  color:
                                                      deliveredForegroundColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 12),
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
                                                'S01.01',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      child: Text(
                                        'Nguyen Ngoc Thinh',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text(
                                      '45.000' + 'đ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
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
                itemCount: _orderList.length,
                itemBuilder: (context, index) {
                  int orderId =
                      _orderList[index].Id != null ? _orderList[index].Id! : 0;

                  main();

                  return Container(
                    margin: EdgeInsets.only(top: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerOrderDetailsPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5.w),
                        height: 15.h,
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                width: 56.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            'ĐƠN #',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            orderId.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 12),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 7),
                                            decoration: BoxDecoration(
                                                color: redColorBackground,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Text(
                                              'Đã hủy',
                                              style: TextStyle(color: redColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 12),
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
                                                'S01.01',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      child: Text(
                                        'Nguyen Ngoc Thinh',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text(
                                      '45.000' + 'đ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
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
    );
  }

  void getValidation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print("token ne`" + token!);
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
                  MaterialPageRoute(builder: (context) => MainApp()),
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
