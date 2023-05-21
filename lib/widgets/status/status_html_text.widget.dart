import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/pages/account.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/link_preview.widget.dart';

class StatusHtmlTextWidget extends StatelessWidget {
  const StatusHtmlTextWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    final dom.Document htmlData = parse(status.content);
    final linkToDisplay =
        htmlData.querySelector("a[rel='nofollow noopener noreferrer']");

    return Column(
      children: [
        Html(
          data: status.content,
          onLinkTap: (url, attributes, element) {
            print(context);
            print(attributes);
            print(element);
            print('display');
            print(linkToDisplay);
            if (attributes.containsKey('class')) {
              if (attributes['class']!.contains('hashtag')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('👷 Hashtags not implemented yet 👷'),
                  ),
                );
                return;
              }
              if (attributes['class']!.contains('mention')) {
                List<String> splitted = url!.split('/');
                getIt
                    .get<ApiService>()
                    .findUserByUsername(splitted[2], splitted[3])
                    .then((Account found) => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AccountPage(account: found),
                            ),
                          )
                        });
              }
            }
          },
        ),
        linkToDisplay != null
            ? LinkPreviewWidget(element: linkToDisplay)
            : const SizedBox(),
      ],
    );
  }
}
