import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/store-staff_repository.dart';
import 'package:vin_ecommerce/data/store_repository.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vin_ecommerce/screens/success_update_profile.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

import 'package:vin_ecommerce/util/util.dart';

class SellerStoreInfoPage extends StatefulWidget {
  const SellerStoreInfoPage({super.key});

  @override
  State<SellerStoreInfoPage> createState() => _SellerStoreInfoPageState();
}

class _SellerStoreInfoPageState extends State<SellerStoreInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController commissionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  StoreStaffRepository staffRepo = new StoreStaffRepository();
  StoreRepository storeRepo = new StoreRepository();
  XFile? myImage = null;
  String imageUrl =
      'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png';
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatas();
  }

  getDatas() async {
    var storeStaff = await staffRepo.getStaff();
    var store =
        await storeRepo.getStoreById(storeStaff.getStoreId().toString());
    setState(() {
      nameController.text = storeStaff?.getStoreName()?.toString() ?? '';
      commissionController.text = store?.getCommission()?.toString() ?? '';
      categoryController.text = store?.getCategoryName()?.toString() ?? '';
      addressController.text = store?.getBuildingName()?.toString() ?? '';
      imageUrl = storeStaff.getStoreAvatarUrl()?.toString() ??
          'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png';
    });
    isLoading = false;
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
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 1.h,
                                      top: 3
                                          .h), // Set the desired vertical margin
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
                                                    builder: (_) =>
                                                        BottomNavBar(
                                                            initialIndex: 4)));
                                          },
                                          child: Image.asset(
                                            'assets/images/back.png',
                                            scale: 1,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'THÔNG TIN CỬA HÀNG',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  //Step 1: Pick image
                                  final ImagePicker _picker = ImagePicker();
                                  myImage = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  print('${myImage?.path}');
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  radius: 8.h,
                                  backgroundImage: myImage != null
                                      ? Image.file(File(myImage!.path)).image
                                      : NetworkImage(imageUrl),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                top: 1.h, right: 4.w, left: 5.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'TÊN CỬA HÀNG',
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
                                      enabled: false,
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
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                top: 1.h, right: 4.w, left: 5.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'LOẠI CỬA HÀNG',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: categoryController,
                                      enabled: false,
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
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                top: 1.h, right: 4.w, left: 5.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'LOẠI CỬA HÀNG',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: categoryController,
                                      enabled: false,
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
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                top: 1.h, right: 4.w, left: 5.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'ĐỊA CHỈ CỬA HÀNG',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: addressController,
                                      enabled: false,
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
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                top: 1.h, right: 4.w, left: 5.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'TỶ LỆ HOA HỒNG',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: commissionController,
                                      enabled: false,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
