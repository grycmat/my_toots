import 'package:flutter/material.dart';

class NoConnectionIconWidget extends StatelessWidget {
  const NoConnectionIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.signal_wifi_bad_outlined,
      size: 60,
      color: Colors.black26,
    );
  }
}
