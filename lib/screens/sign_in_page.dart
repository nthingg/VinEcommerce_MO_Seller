import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/styles/button_style.dart';
import 'package:vin_ecommerce/styles/color.dart';

import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passenable = true;

  // @override
  // void initState() {
  //   super.initState();
  //   checkToken();
  // }

  // Future<void> checkToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   if (token != null) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (_) => BottomNavBar(
  //                 initialIndex: 0,
  //               )),
  //       (route) => false,
  //     );
  //   }
  // }

  // final storage = new FlutterSecureStorage();
  void login(String phone, String password) async {
    try {
      var body = {"phone": phone, "password": password};
      var headers = {'Content-Type': 'application/json'};
      http.Response response = await http.post(
          Uri.parse(
              'https://vinecommerce.bsite.net/api/store-staffs/authorize'),
          headers: headers,
          body: json.encode(body));
      // http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        print(data['accessToken']);
        // final SharedPreferences? prefs = await _prefs;
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('token', data['accessToken']);
        _prefs.setString('pass', password);
        // await storage.write(key: 'token', value: data['accessToken']);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => BottomNavBar(
                      initialIndex: 0,
                    )),
            (route) => false);
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
        backgroundColor: Color(0xff1E1E2E),
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: size.width,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(right: 250),
                        child: Image.asset('assets/images/corner_left.png',
                            height: 120, color: secondaryTextColor)),
                    Text(
                      'Đăng Nhập',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Chào mừng bạn trở lại!',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SỐ ĐIỆN THOẠI',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: double.infinity,
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffA0A5BA))),
                                // border: OutlineInputBorder(),
                                // hintText: "Input Phone here",
                                fillColor: Color(0xffF0F5FA),
                                filled: true),
                            textAlignVertical: TextAlignVertical.center,
                            autofocus: false,
                            style: TextStyle(fontSize: 20),
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
                            'MẬT KHẨU',
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.h, bottom: 1.h),
                        width: size.width,
                        height: 64,
                        child: ElevatedButton(
                          style: elevatedButtonStyle.copyWith(),
                          child: Text('ĐĂNG NHẬP'),
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
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
