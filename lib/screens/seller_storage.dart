import 'package:flutter/material.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/product_repository.dart';
import 'package:vin_ecommerce/data/store-staff_repository.dart';
import 'package:vin_ecommerce/models/product_model.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:vin_ecommerce/styles/color.dart';

class SellerStoragePage extends StatefulWidget {
  const SellerStoragePage({super.key});
  @override
  State<StatefulWidget> createState() => _SellerStoragePageState();
}

class _SellerStoragePageState extends State<SellerStoragePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  ProductRepository productRepo = new ProductRepository();
  StoreStaffRepository staffRepo = new StoreStaffRepository();
  List<Product> _food = [];
  List<Product> _drink = [];
  List<Product> _necesscity = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  getProducts() async {
    var storeStaff = await staffRepo.getStaff();
    var storeId = storeStaff.getStoreId();
    var list = await productRepo.getProductsByStoreId((storeId ?? 0));
    setState(() {
      _food = list.where((product) => product.getCategoryId() == 0).toList();
      _drink = list.where((product) => product.getCategoryId() == 1).toList();
      _necesscity =
          list.where((product) => product.getCategoryId() == 2).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: _food.length,
                  itemBuilder: (context, index) {
                    Product _product = _food[index];
                    return Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/productInfo',
                            arguments: {
                              'productId': _product.getId(),
                              'orderId': 0,
                              'fatherRoute': '/storage',
                            },
                          );
                        },
                        child: Container(
                          height: 19.h,
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.h, right: 4.w, left: 4.w),
                                  child: Image.network(
                                    _product.getImageUrl()?.toString() ??
                                        'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png',
                                    height: 15.h,
                                    fit: BoxFit.scaleDown,
                                    frameBuilder: (context, child, frame,
                                        wasSynchronouslyLoaded) {
                                      return Transform.scale(
                                        scale:
                                            1, // Adjust the scale value to increase or decrease the image size
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _product.getName().toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 6.w),
                                              child: Text(
                                                'Giá ',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              _product.getDiscountPrice() !=
                                                      null
                                                  ? _product
                                                      .getDiscountPrice()
                                                      .toString()
                                                  : _product
                                                      .getOriginalPrice()
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' VND',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (_product?.getIsOutOfStock() ?? false)
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 8, right: 8),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 7),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                14))),
                                                child: Text(
                                                  'Hết hàng',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
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
                  itemCount: _drink.length,
                  itemBuilder: (context, index) {
                    Product _product = _drink[index];
                    return Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/productInfo',
                            arguments: {
                              'productId': _product.getId(),
                              'orderId': 0,
                              'fatherRoute': '/storage',
                            },
                          );
                        },
                        child: Container(
                          height: 19.h,
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.h, right: 4.w, left: 4.w),
                                  child: Image.network(
                                    _product.getImageUrl()?.toString() ??
                                        'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png',
                                    height: 15.h,
                                    fit: BoxFit.scaleDown,
                                    frameBuilder: (context, child, frame,
                                        wasSynchronouslyLoaded) {
                                      return Transform.scale(
                                        scale:
                                            1, // Adjust the scale value to increase or decrease the image size
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _product.getName().toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 6.w),
                                              child: Text(
                                                'Giá ',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              _product.getDiscountPrice() !=
                                                      null
                                                  ? _product
                                                      .getDiscountPrice()
                                                      .toString()
                                                  : _product
                                                      .getOriginalPrice()
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' VND',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                  itemCount: _necesscity.length,
                  itemBuilder: (context, index) {
                    Product _product = _necesscity[index];
                    return Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/productInfo',
                            arguments: {
                              'productId': _product.getId(),
                              'orderId': 0,
                              'fatherRoute': '/storage',
                            },
                          );
                        },
                        child: Container(
                          height: 19.h,
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.h, right: 4.w, left: 4.w),
                                  child: Image.network(
                                    _product.getImageUrl()?.toString() ??
                                        'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png',
                                    height: 15.h,
                                    fit: BoxFit.scaleDown,
                                    frameBuilder: (context, child, frame,
                                        wasSynchronouslyLoaded) {
                                      return Transform.scale(
                                        scale:
                                            1, // Adjust the scale value to increase or decrease the image size
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _product.getName().toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 6.w),
                                              child: Text(
                                                'Giá ',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              _product.getDiscountPrice() !=
                                                      null
                                                  ? _product
                                                      .getDiscountPrice()
                                                      .toString()
                                                  : _product
                                                      .getOriginalPrice()
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' VND',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => BottomNavBar(
                  initialIndex: 1,
                ),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: Image.asset('assets/images/reload.png'),
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
      padding: EdgeInsets.symmetric(horizontal: 12),
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
