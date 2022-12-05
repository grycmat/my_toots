import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('My Account'),
          Row(
            children: [
              CircleAvatar(),
              Column(
                children: [],
              ),
              Column(
                children: [],
              ),
              Column(
                children: [],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
