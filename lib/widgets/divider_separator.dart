import 'package:flutter/material.dart';

class DividerSeparator extends StatelessWidget {
  const DividerSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 5,
      thickness: 1,
      color: Colors.black12,
    );
  }
}
