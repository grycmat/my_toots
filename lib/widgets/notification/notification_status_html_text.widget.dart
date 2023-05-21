import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_toots/models/status/status.dart';

class NotificationStatusHtmlTextWidget extends StatelessWidget {
  const NotificationStatusHtmlTextWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: Html(
            data: status.content,
            onLinkTap: (url, attributes, element) {
              print(url);
              print(attributes);
              print(element);
            },
          ),
        ),
      ],
    );
  }
}
