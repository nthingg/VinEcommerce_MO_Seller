import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_ecommerce/screens/seller_bottom_navbar.dart';
import 'package:vin_ecommerce/screens/sign_in_page.dart';
import 'package:vin_ecommerce/styles/color.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('token').toString();
    Timer(Duration(seconds: 3), () {
      if (token.toString().trim() == "null") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => SignInPage(),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => BottomNavBar(
              initialIndex: 0,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/corner_left.png',
              color: Color(0xffD9D9D9),
            ),
          ),
          Spacer(),
          Container(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 42),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: Text(
                    'Vin',
                    style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 62),
                child: Text(
                  'Ecom',
                  style: TextStyle(fontSize: 42),
                ),
              )
            ],
          )),
          Spacer(),
          Container(
            alignment: Alignment.bottomRight,
            child: Image.asset('assets/images/corner_right.png'),
          )
        ],
      ),
    ));
  }
}
