import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/order_detail_repository.dart';
import 'package:vin_ecommerce/models/order_detail_model.dart';
import 'package:vin_ecommerce/models/order_spec_model.dart';
import 'package:vin_ecommerce/styles/color.dart';
import 'package:vin_ecommerce/screens/seller_orders.dart';

import 'seller_product_info.dart';

class SellerOrderDetailsPage extends StatefulWidget {
  final int orderId;

  const SellerOrderDetailsPage({Key? key, required this.orderId})
      : super(key: key);

  @override
  _SellerOrderDetailsPageState createState() => _SellerOrderDetailsPageState();
}

class _SellerOrderDetailsPageState extends State<SellerOrderDetailsPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  OrderDetailRepository orderDetailRepo = new OrderDetailRepository();
  List<OrderDetail> _orderDetailList = [];
  OrderSpec? _orderSpec;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderDetails(13);
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  getOrderDetails(int orderId) async {
    var list = await orderDetailRepo.getOrderDetailsById(orderId);
    var spec = await orderDetailRepo.getOrderSpec(orderId);
    setState(() {
      _orderDetailList = list;
      _orderSpec = spec;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: _orderDetailList.length,
              itemBuilder: (context, index) {
                OrderDetail orderDetail = _orderDetailList[index];

                return Container(
                  margin: EdgeInsets.only(top: 4),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellerProductInfoPage(
                                  productId: 6,
                                )),
                      );
                    },
                    child: Container(
                      height: 17.5.h,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Image.network(
                                  orderDetail
                                      .getProductImageUrl()
                                      .toString(), // Replace with your image URL
                                  height: 30.w,
                                  fit: BoxFit.scaleDown,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    return Transform.scale(
                                      scale:
                                          0.8, // Adjust the scale value to increase or decrease the image size
                                      child: child,
                                    );
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.only(bottom: 0),
                                    child: Text(
                                      '#' +
                                          orderDetail
                                              .getCategoryName()
                                              .toString(),
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  ),
                                  Container(
                                    width: 66.w,
                                    margin: EdgeInsets.only(top: 4, bottom: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            orderDetail
                                                .getProductName()
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4, bottom: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 9.w),
                                          child: Text(
                                            'Số lượng ',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          orderDetail.getQuantity().toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 1.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 6.w),
                                          child: Text(
                                            'Thành tiền ',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          orderDetail.getPrice().toString(),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          // child: Text(token1.toString()),
        ),
      ),
    );
  }

  PreferredSize _appbar() {
    return PreferredSize(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 12.0), // Set the desired horizontal padding
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, // Set the desired border color here
                width: 1.0, // Set the desired border width here
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topBar(),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(33.h),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: RawMaterialButton(
                  fillColor: Color(0xffECF0F4),
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerOrdersPage()),
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
                    'ĐƠN #' + (_orderSpec?.getId()?.toString() ?? ''),
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
          Container(
            margin: EdgeInsets.only(top: 3.h, left: 4.w),
            child: Row(
              children: [
                Container(
                  width: 28.5.w,
                  child: Text(
                    'Ngày giao: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                ),
                Text(
                  (_orderSpec?.getOrderDate()?.toString() ?? ''),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, left: 4.w),
            child: Row(
              children: [
                Container(
                  width: 28.5.w,
                  child: Text(
                    'Phí giao hàng: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                ),
                Text(
                  (_orderSpec?.getShipFee()?.toString() ?? '') + ' VND',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, left: 4.w),
            child: Row(
              children: [
                Container(
                  width: 28.5.w,
                  child: Text(
                    'Khách hàng: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                ),
                Text(
                  (_orderSpec?.getCustomerName()?.toString() ?? ''),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, left: 4.w),
            child: Row(
              children: [
                Container(
                  width: 28.5.w,
                  child: Text(
                    'Người giao: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                ),
                Text(
                  (_orderSpec?.getShipperName()?.toString() ?? ''),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, left: 4.w),
            child: Row(
              children: [
                Container(
                  width: 28.5.w,
                  child: Text(
                    'Trạng thái: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                ),
                Text(
                  (_orderSpec?.getStatus()?.toString() ?? ''),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
