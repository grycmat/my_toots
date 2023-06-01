import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:share_plus/share_plus.dart';

class ShareButtonWidget extends StatelessWidget {
  const ShareButtonWidget({required this.status, Key? key}) : super(key: key);
  final Status status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Share.share(status.uri!);
          },
          icon: const Icon(
            Icons.share_outlined,
          ),
        ),
      ],
    );
  }
}
