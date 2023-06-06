import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_toots/models/status/status.dart';

class StatusSpoiler extends StatelessWidget {
  const StatusSpoiler({required this.status, Key? key}) : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.amber.shade600,
        ),
        Expanded(child: Html(data: status.spoilerText)),
        const Icon(Icons.read_more_outlined)
      ],
    );
  }
}
