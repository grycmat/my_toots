import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/link_preview.widget.dart';

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
            onLinkTap: (url, context, attributes, element) {
              print(url);
              print(context);
              print(attributes);
              print(element);
            },
          ),
        ),
      ],
    );
  }
}
