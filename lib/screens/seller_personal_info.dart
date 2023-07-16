import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

import 'package:http/http.dart' as http;

class SellerPersonalInfoPage extends StatefulWidget {
  const SellerPersonalInfoPage({super.key});

  @override
  State<SellerPersonalInfoPage> createState() => _SellerPersonalInfoPageState();
}

class _SellerPersonalInfoPageState extends State<SellerPersonalInfoPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passenable = true;
  XFile? myImage = null;
  String imageUrl = '';

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
                              top: 3.h), // Set the desired vertical margin
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
                                                BottomNavBar(initialIndex: 4)));
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

                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          //Step 2: Upload image to firebase storage
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          //Handle error/success
                          try {
                            //Store the file
                            await referenceImageToUpload
                                .putFile(File(myImage!.path));
                            //Success
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            print(imageUrl);
                          } catch (error) {
                            //Error occur
                          }
                        },
                        child: CircleAvatar(
                          radius: 8.h,
                          backgroundImage: myImage != null
                              ? Image.file(File(myImage!.path)).image
                              : AssetImage('assets/images/default_store.png'),
                        ),
                      ),
                    ),
                  ),
                  // selectedImage != null
                  //     ? Image.file(selectedImage!)
                  //     : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: 1.h, right: 4.w, left: 5.w),
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
                              'SỐ ĐIỆN THOẠI',
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
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),

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
                              textAlignVertical: TextAlignVertical.center,
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
                              controller: passwordController,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),

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
                              textAlignVertical: TextAlignVertical.center,
                            ),
                            height: 64,
                          ),
                        ),
                        Container(
                          width: size.width,
                          margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                          height: 64,
                          child: ElevatedButton(
                            style: elevatedButtonStyle.copyWith(),
                            child: Text('LƯU'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          BottomNavBar(initialIndex: 4)),
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

  void getValidation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print("token ne`" + token!);
  }
}
