import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/store-staff_repository.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vin_ecommerce/screens/success_update_profile.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

import 'package:vin_ecommerce/util/util.dart';

class SellerPersonalInfoPage extends StatefulWidget {
  const SellerPersonalInfoPage({super.key});

  @override
  State<SellerPersonalInfoPage> createState() => _SellerPersonalInfoPageState();
}

class _SellerPersonalInfoPageState extends State<SellerPersonalInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  StoreStaffRepository staffRepo = new StoreStaffRepository();
  bool passenable = true;
  XFile? myImage = null;
  String imageUrl =
      'https://htmlcolorcodes.com/assets/images/colors/gray-color-solid-background-1920x1080.png';
  bool isLoading = true;

  bool checkAndShowToast(
      TextEditingController name, TextEditingController email) {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng điền đầy đủ tên!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (email.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng điền đầy đủ email!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    return true;
  }

  bool validatePassword(
      TextEditingController pass, TextEditingController rePass) {
    if (pass.text.toString() != rePass.text.toString()) {
      Fluttertoast.showToast(
        msg: 'Mật khẩu xác nhận không đúng!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (pass.text.isEmpty && !rePass.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng nhập mật khẩu mới trước khi xác nhận!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (pass.text.isEmpty && rePass.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Vui lòng nhập và xác nhận mật khẩu mới!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (pass.text.length < 6 || rePass.text.length < 6) {
      Fluttertoast.showToast(
        msg: 'Mật khẩu chứa ít nhất 6 kí tự!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (pass.text.length < 6 && rePass.text.length < 6) {
      Fluttertoast.showToast(
        msg: 'Mật khẩu chứa ít nhất 6 kí tự!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    return true;
  }

  Future<bool> validateCurrentPassword(
      TextEditingController currentPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pass = prefs.getString('pass');
    if (currentPass.text.toString() != pass) {
      Fluttertoast.showToast(
        msg: 'Mật khẩu hiện tại không đúng!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatas();
  }

  getDatas() async {
    var storeStaff = await staffRepo.getStaff();
    setState(() {
      nameController.text = storeStaff?.getName()?.toString() ?? '';
      emailController.text = storeStaff?.getEmail()?.toString() ?? '';
      imageUrl = storeStaff.getAvatarUrl()?.toString() ??
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
                                            'THÔNG TIN CÁ NHÂN',
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
                                      'TÊN NGƯỜI DÙNG',
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
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'EMAIL',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: emailController,
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 3.h),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'MẬT KHẨU CŨ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: oldPasswordController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),

                                          // border: OutlineInputBorder(),
                                          // hintText: "Input Phone here",
                                          fillColor: Color(0xffF0F5FA),
                                          filled: true,
                                          suffix: IconButton(
                                              onPressed: () {
                                                //add Icon button at end of TextField
                                                setState(() {
                                                  //refresh UI
                                                  if (passenable) {
                                                    //if passenable == true, make it false
                                                    passenable = false;
                                                  } else {
                                                    passenable =
                                                        true; //if passenable == false, make it true
                                                  }
                                                });
                                              },
                                              icon: Icon(passenable == true
                                                  ? Icons.remove_red_eye
                                                  : Icons.password))),
                                      autofocus: false,
                                      obscureText: passenable,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                    ),
                                    height: 64,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 3.h),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'MẬT KHẨU MỚI',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: passwordController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),

                                          // border: OutlineInputBorder(),
                                          // hintText: "Input Phone here",
                                          fillColor: Color(0xffF0F5FA),
                                          filled: true,
                                          suffix: IconButton(
                                              onPressed: () {
                                                //add Icon button at end of TextField
                                                setState(() {
                                                  //refresh UI
                                                  if (passenable) {
                                                    //if passenable == true, make it false
                                                    passenable = false;
                                                  } else {
                                                    passenable =
                                                        true; //if passenable == false, make it true
                                                  }
                                                });
                                              },
                                              icon: Icon(passenable == true
                                                  ? Icons.remove_red_eye
                                                  : Icons.password))),
                                      autofocus: false,
                                      obscureText: passenable,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                    ),
                                    height: 64,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 3.h),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'XÁC NHẬN MẬT KHẨU MỚI',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: rePasswordController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),

                                          // border: OutlineInputBorder(),
                                          // hintText: "Input Phone here",
                                          fillColor: Color(0xffF0F5FA),
                                          filled: true,
                                          suffix: IconButton(
                                              onPressed: () {
                                                //add Icon button at end of TextField
                                                setState(() {
                                                  //refresh UI
                                                  if (passenable) {
                                                    //if passenable == true, make it false
                                                    passenable = false;
                                                  } else {
                                                    passenable =
                                                        true; //if passenable == false, make it true
                                                  }
                                                });
                                              },
                                              icon: Icon(passenable == true
                                                  ? Icons.remove_red_eye
                                                  : Icons.password))),
                                      autofocus: false,
                                      obscureText: passenable,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                    ),
                                    height: 64,
                                  ),
                                ),
                                Container(
                                  width: size.width,
                                  margin:
                                      EdgeInsets.only(top: 4.h, bottom: 4.h),
                                  height: 64,
                                  child: ElevatedButton(
                                    style: elevatedButtonStyle.copyWith(),
                                    child: Text('LƯU'),
                                    onPressed: () async {
                                      if (!checkAndShowToast(
                                          nameController, emailController)) {
                                        return;
                                      }
                                      if (!oldPasswordController.text.isEmpty) {
                                        bool isValid =
                                            await validateCurrentPassword(
                                                oldPasswordController);
                                        if (!isValid) {
                                          return;
                                        }
                                        if (!validatePassword(
                                            passwordController,
                                            rePasswordController)) {
                                          return;
                                        }
                                      }
                                      if (myImage != null) {
                                        imageUrl = await uploadImageToFireBase(
                                            myImage);
                                      }
                                      bool check =
                                          await staffRepo.updateProfile(
                                              nameController.text.toString(),
                                              imageUrl,
                                              emailController.text.toString());
                                      bool passCheck =
                                          await staffRepo.updatePassword(
                                              oldPasswordController.text
                                                  .toString(),
                                              passwordController.text
                                                  .toString());
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SuccessUpdateProfilePage()),
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
                  ),
                )),
    );
  }
}
