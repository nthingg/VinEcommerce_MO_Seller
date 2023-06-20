import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple.shade100,
        body: const Center(
          child: Text(
            'Add',
            style: TextStyle(fontSize: 60, color: Colors.black),
          ),
        ),
      );
}
