import 'package:flutter/material.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/product_repository.dart';
import 'package:vin_ecommerce/models/product_model.dart';
import 'package:vin_ecommerce/screens/seller_product_edit.dart';
import 'package:vin_ecommerce/screens/success_delete_product.dart';

import 'package:vin_ecommerce/styles/color.dart';

class SellerProductInfoPage extends StatefulWidget {
  final int productId;
  final int orderId;
  final String fatherRoute;

  const SellerProductInfoPage(
      {Key? key,
      required this.productId,
      required this.orderId,
      required this.fatherRoute})
      : super(key: key);

  @override
  State<SellerProductInfoPage> createState() => _SellerProductInfoPageState();
}

class _SellerProductInfoPageState extends State<SellerProductInfoPage> {
  ProductRepository productRepo = new ProductRepository();
  Product? _product;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct(widget.productId);
  }

  getProduct(int productId) async {
    var product = await productRepo.getProductById(productId);
    setState(() {
      _product = product;
    });
    isLoading = false;
  }

  void navigateBackToFatherClass() {
    if (widget.fatherRoute == '/orderRequestDetails') {
      Navigator.of(context).pushNamed(
        '/orderRequestDetails',
        arguments: {
          'orderId': widget.orderId,
        },
      );
    } else if (widget.fatherRoute == '/orderDetails') {
      Navigator.of(context).pushNamed(
        '/orderDetails',
        arguments: {
          'orderId': widget.orderId,
        },
      );
    } else {
      Navigator.of(context).pushNamed('/storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: Image.asset('assets/images/loading.gif'),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 2.h,
                                  bottom:
                                      5.h), // Set the desired vertical margin
                              child: Row(
                                children: [
                                  Container(
                                    child: RawMaterialButton(
                                      fillColor: Color(0xffECF0F4),
                                      shape: CircleBorder(),
                                      onPressed: () {
                                        navigateBackToFatherClass();
                                      },
                                      child: Image.asset(
                                        'assets/images/back.png',
                                        scale: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (value) async {
                                      if (value == 'Chỉnh sửa') {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SellerUpdateProductPage(
                                              orderId: widget.orderId,
                                              productId: widget.productId,
                                              fatherRoute: widget.fatherRoute,
                                            ),
                                          ),
                                        );
                                      } else if (value == 'Xóa') {
                                        bool check =
                                            await productRepo.deleteProductById(
                                                widget.productId.toString());

                                        if (check) {
                                          // Reload the page
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SuccessDeleteProductPage(),
                                            ),
                                          );
                                        }
                                      } else if (value == 'Hết hàng') {
                                        bool check =
                                            await productRepo.updateInStock(
                                                widget.productId.toString());

                                        if (check) {
                                          // Reload the page
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SellerProductInfoPage(
                                                orderId: widget.orderId,
                                                productId: widget.productId,
                                                fatherRoute: widget.fatherRoute,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      if (_product?.getIsOutOfStock() ??
                                          false) {
                                        return ['Chỉnh sửa', 'Xóa', 'Còn hàng']
                                            .map((String choice) {
                                          return PopupMenuItem<String>(
                                            value: choice,
                                            child: Text(choice),
                                          );
                                        }).toList();
                                      } else {
                                        return ['Chỉnh sửa', 'Xóa', 'Hết hàng']
                                            .map((String choice) {
                                          return PopupMenuItem<String>(
                                            value: choice,
                                            child: Text(choice),
                                          );
                                        }).toList();
                                      }
                                    },
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
                            fit:
                                BoxFit.cover, // Set the desired BoxFit property
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 3.h, right: 3.w, left: 8.w),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
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
                      if (_product?.getIsOutOfStock() ?? false)
                        Container(
                          margin: EdgeInsets.only(right: 6.w, left: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8, right: 8),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Text(
                                  'Hết hàng',
                                  style: TextStyle(color: Colors.black),
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
                                  (_product?.getOriginalPrice()?.toString() ??
                                          '') +
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
                                  (_product?.getOriginalPrice()?.toString() ??
                                          '') +
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
                                  (_product?.getDiscountPrice()?.toString() ??
                                          '') +
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
                        padding:
                            EdgeInsets.only(left: 8.w, right: 8.w, top: 4.h),
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
              ),
      ),
    );
  }
}
