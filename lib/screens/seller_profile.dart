import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/store-staff_repository.dart';
import 'package:vin_ecommerce/models/store-staff_model.dart';
import 'package:vin_ecommerce/screens/seller_reviews.dart';
import 'package:vin_ecommerce/screens/seller_store_info.dart';
import 'package:vin_ecommerce/screens/sign_in_page.dart';
import 'package:vin_ecommerce/styles/color.dart';
import 'package:vin_ecommerce/screens/seller_personal_info.dart';

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({super.key});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  StoreStaffRepository staffRepo = new StoreStaffRepository();
  StoreStaff? staff;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatas();
  }

  getDatas() async {
    var storeStaff = await staffRepo.getStaff();
    setState(() {
      staff = storeStaff;
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
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24))),
                          width: size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        2.h), // Set the desired vertical margin
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: CircleAvatar(
                                    radius: 7
                                        .h, // Set the desired radius for the circular image
                                    backgroundImage: NetworkImage(staff
                                            ?.getAvatarUrl()
                                            ?.toString() ??
                                        'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png'),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        3.h), // Set the desired vertical margin
                                child: Text(
                                  staff?.getName()?.toString() ?? '',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'SF Pro Text',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3.h, right: 5.w, left: 4.w),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets
                                          .zero, // Remove default padding
                                      shape: RoundedRectangleBorder(
                                        // Add a rounded shape if desired
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Colors.white),
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                SellerPersonalInfoPage()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.6.h),
                                    decoration: BoxDecoration(
                                      color:
                                          lightGrayColor, // Set the desired background color
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3
                                                  .w), // Set the desired margin value
                                          child: Image.asset(
                                            'assets/images/personal_info_icon.png',
                                            fit: BoxFit.scaleDown,
                                            frameBuilder: (context, child,
                                                frame, wasSynchronouslyLoaded) {
                                              return Transform.scale(
                                                scale: 1,
                                                child: child,
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 56.w,
                                          child: Text(
                                            'Thông tin nhân viên',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.5
                                                  .w), // Set the desired margin value
                                          child: Image.asset(
                                            'assets/images/arrow_right_icon.png',
                                            fit: BoxFit.scaleDown,
                                            frameBuilder: (context, child,
                                                frame, wasSynchronouslyLoaded) {
                                              return Transform.scale(
                                                scale: 1,
                                                child: child,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 3.h, right: 5.w, left: 4.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.zero, // Remove default padding
                                shape: RoundedRectangleBorder(
                                  // Add a rounded shape if desired
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor: Colors.white),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SellerStoreInfoPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.6.h),
                              decoration: BoxDecoration(
                                color:
                                    lightGrayColor, // Set the desired background color
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/store-info.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 56.w,
                                    child: Text(
                                      'Thông tin cửa hàng',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.5
                                            .w), // Set the desired margin value
                                    child: Image.asset(
                                      'assets/images/arrow_right_icon.png',
                                      fit: BoxFit.scaleDown,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return Transform.scale(
                                          scale: 1,
                                          child: child,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3.h, right: 5.w, left: 4.w),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets
                                          .zero, // Remove default padding
                                      shape: RoundedRectangleBorder(
                                        // Add a rounded shape if desired
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Colors.white),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove('token');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignInPage()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.6.h),
                                    decoration: BoxDecoration(
                                      color:
                                          lightGrayColor, // Set the desired background color
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3
                                                  .w), // Set the desired margin value
                                          child: Image.asset(
                                            'assets/images/logout_icon.png',
                                            fit: BoxFit.scaleDown,
                                            frameBuilder: (context, child,
                                                frame, wasSynchronouslyLoaded) {
                                              return Transform.scale(
                                                scale: 1,
                                                child: child,
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 56.w,
                                          child: Text(
                                            'Đăng xuất',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.5
                                                  .w), // Set the desired margin value
                                          child: Image.asset(
                                            'assets/images/arrow_right_icon.png',
                                            fit: BoxFit.scaleDown,
                                            frameBuilder: (context, child,
                                                frame, wasSynchronouslyLoaded) {
                                              return Transform.scale(
                                                scale: 1,
                                                child: child,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
