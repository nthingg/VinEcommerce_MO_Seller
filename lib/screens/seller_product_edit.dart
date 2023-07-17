import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

import 'package:http/http.dart' as http;

class SellerUpdateProductPage extends StatefulWidget {
  const SellerUpdateProductPage({super.key});

  @override
  State<SellerUpdateProductPage> createState() =>
      _SellerUpdateProductPageState();
}

class _SellerUpdateProductPageState extends State<SellerUpdateProductPage> {
  List<String> categories = ['Đồ ăn', 'Thức uống', 'Nhu yếu phẩm'];
  String selectedCategory =
      ''; // Declare a variable to hold the selected category
  File?
      selectedImage; // Declare a nullable variable to hold the selected image file
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String phone, String password) async {
    try {
      var body = {"phone": phone, "password": password};
      var headers = {'Content-Type': 'application/json'};
      http.Response response = await http.post(
          Uri.parse(
              'http://www.vinecommerce.somee.com/api/StoreStaff/Authorize'),
          headers: headers,
          body: json.encode(body));
      // http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        print(data['accessToken']);
        // final SharedPreferences? prefs = await _prefs;
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('token', data['accessToken']);
        // await storage.write(key: 'token', value: data['accessToken']);
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else {
        print('\n2\n');
      }
    } catch (e) {
      print('3');
      print(e.toString());
    }
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
                              bottom: 1.h,
                              top: 4.h,
                              left: 4.w), // Set the desired vertical margin
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'THÊM SẢN PHẨM',
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
                              value: categories[0],
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
                              controller: passwordController,
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
                                PickedFile? image = await _picker.getImage(
                                    source: ImageSource.gallery);
                              },
                              child: Image.asset(
                                'assets/images/add_image.png',
                                scale: 4,
                              ),
                            ),
                          ),
                        ),
                        selectedImage != null
                            ? Image.file(selectedImage!)
                            : Container(),
                        const SizedBox(
                          height: 10,
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
                                          controller: passwordController,
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
                                          controller: passwordController,
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
                            child: Text('THÊM'),
                            onPressed: () {
                              login(phoneController.text.toString(),
                                  passwordController.text.toString());
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => VerificationPage()),
                              //     (route) => false);
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

  void getValidation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print("token ne`" + token!);
  }
}
