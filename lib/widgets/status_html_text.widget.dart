import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_toots/models/status/status.dart';

class StatusHtmlTextWidget extends StatelessWidget {
  const StatusHtmlTextWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: status.content,
      style: {'p': Style(fontSize: FontSize(8))},
      onLinkTap: (url, context, attributes, element) {
        print(url);
        print(context);
        print(attributes);
        print(element);
      },
    );
  }
}
