import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.red.shade100,
        body: const Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 60, color: Colors.black),
          ),
        ),
      );
}
