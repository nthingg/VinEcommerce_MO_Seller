import 'package:flutter/material.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/screens/seller_product_info.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

class SuccessUpdateProductPage extends StatefulWidget {
  final int productId;
  final int orderId;
  final String fatherRoute;

  const SuccessUpdateProductPage(
      {Key? key,
      required this.productId,
      required this.orderId,
      required this.fatherRoute})
      : super(key: key);

  @override
  State<SuccessUpdateProductPage> createState() =>
      _SuccessUpdateProductPageState();
}

class _SuccessUpdateProductPageState extends State<SuccessUpdateProductPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              padding: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, bottom: 5.h),
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/check.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'CẬP NHẬT SẢN PHẨM THÀNH CÔNG',
                        style: TextStyle(fontSize: 20, color: primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                    height: 64,
                    child: ElevatedButton(
                      style: elevatedButtonStyle.copyWith(),
                      child: Text('TRỞ VỀ'),
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SellerProductInfoPage(
                                orderId: widget.orderId,
                                productId: widget.productId,
                                fatherRoute: widget.fatherRoute,
                              ),
                            ),
                            (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
