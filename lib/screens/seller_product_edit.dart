import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/product_repository.dart';
import 'package:vin_ecommerce/screens/seller_product_info.dart';
import 'package:vin_ecommerce/screens/success_update_product.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';
import 'package:vin_ecommerce/util/util.dart';

class SellerUpdateProductPage extends StatefulWidget {
  final int productId;
  final int orderId;
  final String fatherRoute;

  const SellerUpdateProductPage(
      {Key? key,
      required this.productId,
      required this.orderId,
      required this.fatherRoute})
      : super(key: key);

  @override
  State<SellerUpdateProductPage> createState() =>
      _SellerUpdateProductPageState();
}

class _SellerUpdateProductPageState extends State<SellerUpdateProductPage> {
  ProductRepository productRepo = new ProductRepository();

  XFile? myImage;
  String imageUrl =
      'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png';

  List<String> categories = ['Đồ ăn', 'Thức uống', 'Nhu yếu phẩm'];
  String selectedCategory = 'Đồ ăn';
  int categoryId = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController reducePriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct(widget.productId);
  }

  getProduct(int productId) async {
    var product = await productRepo.getProductById(productId);
    setState(() {
      nameController.text = product.getName()?.toString() ?? '';
      originalPriceController.text =
          product?.getOriginalPrice()?.toString() ?? '';
      reducePriceController.text =
          product?.getDiscountPrice()?.toString() ?? '';
      descriptionController.text = product?.getDescription()?.toString() ?? '';
      categoryId = product.getCategoryId()!;
      imageUrl = product.getImageUrl()?.toString() ??
          'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png';
      selectedCategory = product.getCategoryName()!;
    });
  }

  bool checkAndShowToast(TextEditingController name,
      TextEditingController price, TextEditingController discountPrice) {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng điền đầy đủ tên sản phẩm!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (price.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng điền đầy đủ giá tiền gốc!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (!discountPrice.text.isEmpty) {
      int priceValue;

      try {
        priceValue = int.parse(price.text.toString());
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Trường giá sau giảm là chữ số!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }
    } else if (!price.text.isEmpty) {
      int priceValue;

      try {
        priceValue = int.parse(price.text.toString());
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Trường giá gốc là chữ số!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }

      if (priceValue == 0) {
        Fluttertoast.showToast(
          msg: 'Trường giá gốc yêu cầu số tự nhiên lớn 0!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }
    }
    return true;
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
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 2.h), // Set the desired vertical margin
                          child: Row(
                            children: [
                              Container(
                                child: RawMaterialButton(
                                  fillColor: Color(0xffECF0F4),
                                  shape: CircleBorder(),
                                  onPressed: () {
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
                                    'CHỈNH SỬA SẢN PHẨM',
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: 3.h, right: 4.w, left: 5.w),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'LOẠI SÁN PHẨM',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              value: categories[categoryId],
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCategory = newValue!;
                                });
                              },
                              items: categories.map((category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Container(
                                    child: Text(category),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.5),
                                ),
                                fillColor: Color(0xffF0F5FA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a category';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'TÊN SẢN PHẨM',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.5)),

                                // border: OutlineInputBorder(),
                                // hintText: "Input Phone here",
                                fillColor: Color(0xffF0F5FA),
                                filled: true,
                              ),
                              autofocus: false,
                              textAlignVertical: TextAlignVertical.center,
                            ),
                            height: 64,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'TẢI HÌNH ẢNH',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                              // fillColor: Color(0xffECF0F4),
                              // shape: LinearBorder(),
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // Remove default padding
                                  shape: RoundedRectangleBorder(
                                    // Add a rounded shape if desired
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Colors.white),
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                myImage = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                print('${myImage?.path}');
                                setState(() {});
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 90.w,
                                  height: 50.h,
                                  child: myImage != null
                                      ? Image.file(File(myImage!.path),
                                          fit: BoxFit.cover)
                                      : Image.network(imageUrl!.toString(),
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 3.h),
                                      child: Container(
                                        width: 20.h,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'GIÁ GỐC',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Container(
                                        width: 20.h,
                                        child: TextField(
                                          controller: originalPriceController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange,
                                                    width: 1.5)),

                                            // border: OutlineInputBorder(),
                                            // hintText: "Input Phone here",
                                            fillColor: Color(0xffF0F5FA),
                                            filled: true,
                                          ),
                                          autofocus: false,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                        ),
                                        height: 64,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 3.h),
                                      child: Container(
                                        width: 20.h,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'GIÁ SAU GIẢM',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Container(
                                        width: 20.h,
                                        child: TextField(
                                          controller: reducePriceController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange,
                                                    width: 1.5)),

                                            // border: OutlineInputBorder(),
                                            // hintText: "Input Phone here",
                                            fillColor: Color(0xffF0F5FA),
                                            filled: true,
                                          ),
                                          autofocus: false,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                        ),
                                        height: 64,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'CHI TIẾT SẢN PHẨM',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            child: TextField(
                              controller: descriptionController,
                              maxLines:
                                  null, // Set maxLines to null for multiline text area
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.5)),
                                // Adjust the vertical padding
                                fillColor: Color(0xffF0F5FA),
                                filled: true,
                              ),
                              autofocus: false,
                              textAlignVertical: TextAlignVertical.center,
                            ),
                            constraints: BoxConstraints(
                              maxHeight: 120, // Set the maximum height to 120
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                          height: 64,
                          child: ElevatedButton(
                            style: elevatedButtonStyle.copyWith(),
                            child: Text('HOÀN TẤT'),
                            onPressed: () async {
                              if (!checkAndShowToast(
                                  nameController,
                                  originalPriceController,
                                  reducePriceController)) {
                                return;
                              }
                              if (descriptionController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Vui lòng điền đầy đủ mô tả sản phẩm!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                                return;
                              }
                              if (myImage != null) {
                                imageUrl = await uploadImageToFireBase(myImage);
                              }
                              bool check = await productRepo.updateProductById(
                                  selectedCategory,
                                  nameController.text.toString(),
                                  imageUrl.toString(),
                                  descriptionController.text.toString(),
                                  originalPriceController.text.toString(),
                                  reducePriceController.text.toString(),
                                  widget.productId.toString());
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SuccessUpdateProductPage(
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
                ],
              ),
            ),
          )),
    );
  }
}
