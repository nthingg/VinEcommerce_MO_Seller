import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: const Center(
          child: Text(
            'Notification',
            style: TextStyle(fontSize: 60, color: Colors.black),
          ),
        ),
      );
}
