import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/styles/app_assets.dart';
import 'package:vin_ecommerce/styles/color.dart';

import '../../models/order_model.dart';
import 'seller_product_info.dart';

class SellerStoragePage extends StatefulWidget {
  const SellerStoragePage({super.key});
  @override
  State<StatefulWidget> createState() => _SellerStoragePageState();
}

class _SellerStoragePageState extends State<SellerStoragePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
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
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SellerProductInfoPage()),
                            );
                          },
                          child: Container(
                            height: 20.h,
                            child: Column(children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Image.asset(
                                      'assets/images/default_store.png',
                                      height: 140,
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale:
                                              1.8, // Adjust the scale value to increase or decrease the image size
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Tôm sốt trứng muối',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 8, right: 8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        decoration: BoxDecoration(
                                            color: pendingBackgroundColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))),
                                        child: Text(
                                          'Món ăn',
                                          style: TextStyle(color: primaryColor),
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
                                                    'assets/images/star.png'),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '3.0',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '(' + '12' + ' Đánh giá)',
                                                  style: TextStyle(
                                                      color:
                                                          secondaryTextColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 6.w),
                                        child: Text(
                                          '125.000' + 'đ',
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
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SellerProductInfoPage()),
                            );
                          },
                          child: Container(
                            height: 20.h,
                            child: Column(children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Image.asset(
                                      'assets/images/default_store.png',
                                      height: 140,
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale:
                                              1.8, // Adjust the scale value to increase or decrease the image size
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Nước dừa',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 8, right: 8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        decoration: BoxDecoration(
                                            color: pendingBackgroundColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))),
                                        child: Text(
                                          'Thức uống',
                                          style: TextStyle(color: primaryColor),
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
                                                    'assets/images/star.png'),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '4.5',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '(' + '8' + ' Đánh giá)',
                                                  style: TextStyle(
                                                      color:
                                                          secondaryTextColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 6.w),
                                        child: Text(
                                          '12.000' + 'đ',
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
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SellerProductInfoPage()),
                            );
                          },
                          child: Container(
                            height: 20.h,
                            child: Column(children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Image.asset(
                                      'assets/images/default_store.png',
                                      height: 140,
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale:
                                              1.8, // Adjust the scale value to increase or decrease the image size
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Gạo',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 8, right: 8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        decoration: BoxDecoration(
                                            color: pendingBackgroundColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))),
                                        child: Text(
                                          'Nhu yếu phẩm',
                                          style: TextStyle(color: primaryColor),
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
                                                    'assets/images/star.png'),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '4.0',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '(' + '2' + ' Đánh giá)',
                                                  style: TextStyle(
                                                      color:
                                                          secondaryTextColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 6.w),
                                        child: Text(
                                          '50.000' + 'đ',
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
          )),
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
        preferredSize: Size.fromHeight(16.h));
  }

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, left: 4.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KHO',
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
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: TabBar(
          controller: tabController,
          indicatorColor: primaryColor,
          labelColor: primaryColor,
          unselectedLabelColor: secondaryTextColor,
          tabs: const [
            Tab(text: 'Món ăn'),
            Tab(text: 'Thức uống'),
            Tab(text: 'Nhu yếu phẩm'),
          ],
        ),
      ),
    );
  }
}
