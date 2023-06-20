import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
        body: const Center(
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 60, color: Colors.black),
          ),
        ),
      );
}
