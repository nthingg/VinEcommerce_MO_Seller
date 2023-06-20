import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.brown.shade100,
        body: const Center(
          child: Text(
            'Order List',
            style: TextStyle(fontSize: 60, color: Colors.black),
          ),
        ),
      );
}
