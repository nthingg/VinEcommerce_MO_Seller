import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/order_repository.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:vin_ecommerce/screens/seller_order_details_request.dart';
import 'package:vin_ecommerce/styles/color.dart';

import '../../models/order_model.dart';

class SellerRequestOrdersPage extends StatefulWidget {
  const SellerRequestOrdersPage({super.key});
  @override
  State<StatefulWidget> createState() => _SellerRequestOrdersPageState();
}

class _SellerRequestOrdersPageState extends State<SellerRequestOrdersPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  OrderRepository orderRepo = new OrderRepository();
  List<Order> _orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  getOrders() async {
    var list = await orderRepo.getPendingOrders();
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
        body: Container(
          color: Colors.grey[300],
          child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _orderList.length,
                  itemBuilder: (context, index) {
                    Order order = _orderList[index];
                    int orderId = _orderList[index].Id != null
                        ? _orderList[index].Id!
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
                                builder: (context) =>
                                    SellerRequestOrderDetailsPage(
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
                                                      lightYellowColorBackground,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(14))),
                                              child: Text(
                                                order.getStatus().toString(),
                                                style: TextStyle(
                                                    color: yellowColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 25, top: 2.h),
                                        child: Text(
                                          'TỪ',
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
                                          'ĐẾN',
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
                                              'Khách hàng',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
            // _tabBar(),
          ],
        )),
        preferredSize: Size.fromHeight(11.h));
  }

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
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
                'ĐƠN ĐANG XỬ LÝ',
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
}
